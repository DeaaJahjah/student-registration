import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/registration/screens/father_info.dart';

class ContactInformation extends StatefulWidget {
  static const routeName = '/contact_information';
  const ContactInformation({Key? key}) : super(key: key);

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  final permanentAddressController = TextEditingController();
  final currentAddressController = TextEditingController();
  final friendAddressController = TextEditingController();
  final phoneNumController = TextEditingController();
  final emailController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                RegistrationAppBare(title: 'معلومات الاتصال'),
                sizedBoxSmall,
                TextInput(
                  controller: permanentAddressController,
                  labelText: 'العنوان الدائم بالتفصيل',
                  maxLines: 3,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: currentAddressController,
                  labelText: 'العنوان الحالي بالتفصيل',
                  maxLines: 3,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: friendAddressController,
                  labelText: 'عنوان أقرب شخص يمكن العودة إليه عند الضرورة',
                  maxLines: 3,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: phoneNumController,
                  labelText: 'رقم الهاتف',
                  keyboardType: TextInputType.phone,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: emailController,
                  labelText: 'البريد الإلكتروني',
                  keyboardType: TextInputType.emailAddress,
                ),
                sizedBoxMedium,
                Center(
                    child: ButtonWithShadow(
                  text: 'التالي',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (!_key.currentState!.validate()) {
                      return;
                    }
                    _key.currentState!.save();
                    context.read<RegistrationProvider>().student =
                        context.read<RegistrationProvider>().student.copyWith(
                              currentAddress: currentAddressController.text,
                              originalAdderss: permanentAddressController.text,
                              friendAddress: friendAddressController.text,
                              phoneNumber: phoneNumController.text,
                              email: emailController.text,
                            );
                    Navigator.of(context).pushNamed(FatherInfo.routeName);
                  },
                )),
                sizedBoxSmall,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
