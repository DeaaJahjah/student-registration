import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/config/widgets/wife_info.dart';
import 'package:student_registeration_system/features/registration/screens/bro_sis_info_screen.dart';

import '../providers/registration_provider.dart';

class MotherInfo extends StatefulWidget {
  static const routeName = '/mother_info';
  const MotherInfo({Key? key}) : super(key: key);

  @override
  State<MotherInfo> createState() => _MotherInfoState();
}

class _MotherInfoState extends State<MotherInfo> {
  final nameController = TextEditingController();
  final nationalityController = TextEditingController();
  final ageController = TextEditingController();
  final _key = GlobalKey<FormState>();
  int? _groupValue = 0;
  DateTime? birthday;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                RegistrationAppBare(title: 'بيانات الأم'),
                sizedBoxSmall,
                TextInput(
                  controller: nameController,
                  labelText: 'الاسم والشهرة',
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
                sizedBoxLarge,
                Text(
                  'الوضع العائلي',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                // sizedBoxSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('متزوج', style: Theme.of(context).textTheme.displayLarge),
                    Radio(
                        hoverColor: secondaryColor,
                        value: 1,
                        activeColor: secondaryColor,
                        groupValue: _groupValue,
                        onChanged: (newValue) {
                          setState(() {
                            _groupValue = newValue;
                          });
                        }),
                    Text('أعزب', style: Theme.of(context).textTheme.displayLarge),
                    Radio(
                        value: 0,
                        activeColor: secondaryColor,
                        groupValue: _groupValue,
                        onChanged: (newValue) {
                          setState(() {
                            _groupValue = newValue;
                          });
                        }),
                  ],
                ),
                if (_groupValue == 1) const WifeInfo(),
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
                              motherName: nameController.text,
                              motherAge: birthday,
                              motherNationality: nationalityController.text,
                              maritalStatus: _groupValue == 0 ? false : true,
                            );
                    print(context.read<RegistrationProvider>().student);
                    Navigator.of(context).pushNamed(BroAndSisInfo.routeName);
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
