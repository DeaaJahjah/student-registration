import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/registration/models/certificate.dart';
import 'package:student_registeration_system/registration/screens/college_info.dart';

import '../providers/registration_provider.dart';

class HighSchoolSertificat extends StatefulWidget {
  static const routeName = '/high_school_sertificate';
  const HighSchoolSertificat({Key? key}) : super(key: key);

  @override
  State<HighSchoolSertificat> createState() => _HighSchoolSertificatState();
}

class _HighSchoolSertificatState extends State<HighSchoolSertificat> {
  final certificateTypeController = TextEditingController();
  final majorController = TextEditingController();
  final successCycleController = TextEditingController();
  final successAverageController = TextEditingController();
  final certificateNumController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? date;
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
                RegistrationAppBare(title: ' الشهادة الثانوية'),
                sizedBoxSmall,
                TextInput(
                  controller: certificateTypeController,
                  labelText: 'نوع الشهادة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: majorController,
                  labelText: 'الفرع',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: successCycleController,
                  labelText: 'دورة النجاح',
                  keyboardType: TextInputType.number,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: successAverageController,
                  labelText: 'معدل النجاح بعد حذف الديانة',
                  keyboardType: TextInputType.number,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: certificateNumController,
                  labelText: 'رقم الشهادة',
                  keyboardType: TextInputType.number,
                ),
                sizedBoxSmall,
                TextInput(
                  controller: dateController,
                  labelText: 'تاريخ الشهادة',
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    date = await showRoundedDatePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      initialDate: DateTime(1990),
                      // firstDate: DateTime(2000),
                      theme: ThemeData(primarySwatch: Colors.indigo),
                    );
                    dateController.text = ('${date!.year}-${date!.month}-${date!.day}').toString();
                  },
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
                              certificate: Certificate(
                                  id: certificateNumController.text,
                                  type: certificateTypeController.text,
                                  major: majorController.text,
                                  successCycle: successCycleController.text,
                                  average: double.tryParse(successAverageController.text)!,
                                  date: date!),
                            );
                    Navigator.of(context).pushNamed(CollegeInfo.routeName);
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
