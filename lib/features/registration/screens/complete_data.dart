import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/features/registration/screens/contact_information.dart';

class CompleteData extends StatefulWidget {
  static const routeName = '/complete_data';
  const CompleteData({Key? key}) : super(key: key);

  @override
  State<CompleteData> createState() => _CompleteDataState();
}

class _CompleteDataState extends State<CompleteData> {
  final governorateController = TextEditingController();
  final areaController = TextEditingController();
  final faceColorController = TextEditingController();
  final eyesColorController = TextEditingController();
  final heightController = TextEditingController();
  final specialMarksController = TextEditingController();
  final registrationInfoController = TextEditingController();
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
                RegistrationAppBare(title: 'أكمل البيانات'),
                sizedBoxSmall,
                TextInput(
                  controller: governorateController,
                  labelText: 'المحافظة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: areaController,
                  labelText: 'المنطقة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: faceColorController,
                  labelText: 'لون الوجه',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: eyesColorController,
                  labelText: 'لون العيون',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: heightController,
                  labelText: 'الطول',
                  keyboardType: TextInputType.number,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: specialMarksController,
                  labelText: 'العلامات الفارقة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: registrationInfoController,
                  labelText: 'محل القيد ورقمه',
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
                    context.read<RegistrationProvider>().student = context
                        .read<RegistrationProvider>()
                        .student
                        .copyWith(
                            province: governorateController.text,
                            area: areaController.text,
                            faceColor: faceColorController.text,
                            eyesColor: eyesColorController.text,
                            studentHigh: heightController.text,
                            specialMarks: specialMarksController.text,
                            recordNameNumber: registrationInfoController.text);

                    Navigator.of(context).pushNamed(ContactInformation.routeName);
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
