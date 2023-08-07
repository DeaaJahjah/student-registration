import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/screens/mother_info.dart';

import '../providers/registration_provider.dart';

class FatherInfo extends StatefulWidget {
  static const routeName = '/father_info';
  const FatherInfo({Key? key}) : super(key: key);

  @override
  State<FatherInfo> createState() => _FatherInfoState();
}

class _FatherInfoState extends State<FatherInfo> {
  final nameController = TextEditingController();
  final nationalityController = TextEditingController();
  final ageController = TextEditingController();
  final workController = TextEditingController();
  final annualIncomeController = TextEditingController();
  DateTime? birthday;
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
                RegistrationAppBare(title: 'بيانات الأب'),
                sizedBoxSmall,
                TextInput(
                  controller: nameController,
                  labelText: 'الاسم',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: nationalityController,
                  labelText: 'الجنسية',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: ageController,
                  labelText: 'العمر',
                  readOnly: true,
                  onTap: () async {
                    birthday = await showRoundedDatePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      initialDate: DateTime(1990),
                      // firstDate: DateTime(2000),
                      theme: ThemeData(primarySwatch: Colors.indigo),
                    );
                    ageController.text = ('${birthday!.year}-${birthday!.month}-${birthday!.day}').toString();
                  },
                ),
                sizedBoxSmall,
                TextInput(
                  controller: workController,
                  labelText: 'العمل',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: annualIncomeController,
                  labelText: 'الدخل السنوي',
                  keyboardType: TextInputType.number,
                ),
                sizedBoxLarge,
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
                              fatherName: nameController.text,
                              fatherAge: birthday,
                              fatherNationality: nationalityController.text,
                              fatherJob: workController.text,
                              fatherAnnualSalary: double.parse(annualIncomeController.text),
                            );
                    Navigator.of(context).pushNamed(MotherInfo.routeName);
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
