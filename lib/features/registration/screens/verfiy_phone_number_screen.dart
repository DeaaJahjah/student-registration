import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/shadow_button.dart';
import 'package:student_registeration_system/features/registration/services/student_db_services.dart';

import '../providers/registration_provider.dart';

class VerfiyPhoneNumberScree extends StatefulWidget {
  static const routeName = '/verfiy-phone-number';
  const VerfiyPhoneNumberScree({super.key});

  @override
  State<VerfiyPhoneNumberScree> createState() => _VerfiyPhoneNumberScreeState();
}

class _VerfiyPhoneNumberScreeState extends State<VerfiyPhoneNumberScree> {
  final otpController = TextEditingController();

  bool isLoading = false;
  bool isLoadingOTP = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationIDFromFirebase;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      isLoading = true;
      setState(() {});

      try {
        await auth.verifyPhoneNumber(
          phoneNumber: '+966 ${context.read<RegistrationProvider>().student.phoneNumber}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, '${error.message}');
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              isLoading = false;
              verificationIDFromFirebase = verificationId;
            });
          },
        );
        // setState(() {
        //   isLoading = false;
        // });
      } catch (e) {
        isLoading = false;

        showErrorSnackBar(context, e.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RegistrationAppBare(
              title: 'تأكيد رقم الهاتف',
            ),
            const Text(
              "ادخل رمز التحقق",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Text('ادخل رمز التأكيد',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: secondaryColor)),
            const SizedBox(
              height: 20.0,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinCodeTextField(
                  appContext: context,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  autoUnfocus: true,
                  // backgroundColor: primaryColor,
                  enableActiveFill: true,

                  pinTheme: PinTheme(
                      inactiveFillColor: primaryColor,
                      inactiveColor: primaryColor,
                      activeFillColor: secondaryColor,
                      activeColor: primaryColor,
                      selectedFillColor: primaryColor,
                      selectedColor: primaryColor),
                  boxShadows: const [
                    BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                  ],
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            !isLoadingOTP
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ShadowButton(
                      title: 'موافق',
                      onTap: () => _verifyOTPButton(),
                    ),
                  )
                : const CustomProgress(),
          ],
        ),
      ),
    );
  }

  _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(verificationId: verificationIDFromFirebase, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isLoadingOTP = true;
    });
    try {
      final authCredential = await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        if (mounted) {
          await StudentsDbService().creatUser(context: context, student: context.read<RegistrationProvider>().student);
          setState(() {
            isLoadingOTP = false;
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoadingOTP = false;
      });
      showErrorSnackBar(context, e.message.toString());
    }
  }
}
