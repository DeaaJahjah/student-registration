import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/shadow_button.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/home/screens/home_screen.dart';
import 'package:student_registeration_system/registration/screens/personal_data.dart';
import 'package:student_registeration_system/registration/services/student_db_services.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final phoneNumcontroller = TextEditingController();

  final otpController = TextEditingController();

  bool isLoading = false;
  bool isLoadingOTP = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationIDFromFirebase;
  PhoneVerificationState currentState = PhoneVerificationState.SHOW_PHONE_FORM_STATE;

  @override
  Widget build(BuildContext context) {
    // isLoading = false;

    return currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
        ? Scaffold(
            backgroundColor: primaryColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  sizedBoxLarge,
                  Text(
                    '''عزيزي الطالب
      يمكنك التسجيل ودفع 
      رسومك الجامعية أينما كنت 
      أهلاً بك
          ''',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  TextInput(
                      keyboardType: TextInputType.number, labelText: 'أدخل رقم الهاتف', controller: phoneNumcontroller),
                  sizedBoxLarge,
                  isLoading
                      ? const CustomProgress()
                      : ButtonWithShadow(
                          text: 'تسجيل الدخول',
                          onTap: () async {
                            isLoading = true;
                            setState(() {});
                            if (phoneNumcontroller.text.length != 9) {
                              showErrorSnackBar(context, 'يجب ان يكون رقم الهاتف تسع أرقام');

                              isLoading = false;
                              setState(() {});
                              return;
                            }

                            try {
                              await auth.verifyPhoneNumber(
                                phoneNumber: '+966 ${phoneNumcontroller.text}',
                                verificationCompleted: (PhoneAuthCredential credential) async {
                                  // ANDROID ONLY!

                                  // Sign the user in (or link) with the auto-generated credential
                                  await auth.signInWithCredential(credential);

                                  // Navigator.of(context).pushNamed(PersonalData.routeName);
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
                                    currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
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
                          }),
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pushNamed(PersonalData.routeName);
                    },
                    child: Text(
                      'طالب مستجد',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  )
                ],
              ),
            ),
          )
        : getOTPFormWidget();
  }

  getOTPFormWidget() {
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
      setState(() {
        isLoadingOTP = false;
      });
      if (authCredential.user != null) {
        final accountState = await StudentsDbService().checkAccountStatus(context);

        print('accountState $accountState');
        if (accountState == 'مفعل') {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          showErrorSnackBar(context, ' الحساب $accountState. الرجاء المحاولة لاحقا');
          await auth.signOut();
        }
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoadingOTP = false;
      });
      showErrorSnackBar(context, e.message.toString());
    }
  }
}
