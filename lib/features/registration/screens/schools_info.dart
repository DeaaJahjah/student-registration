import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/models/school.dart';
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/features/registration/screens/high_school_sertificat.dart';
import 'dart:math';

class SchoolsInfo extends StatefulWidget {
  static const routeName = '/school-info';
  const SchoolsInfo({Key? key}) : super(key: key);

  @override
  State<SchoolsInfo> createState() => _SchoolsInfoState();
}

class _SchoolsInfoState extends State<SchoolsInfo> {
  final schoolNameController1 = TextEditingController();
  final cityController1 = TextEditingController();
  final governorateController1 = TextEditingController();
  final schoolNameController2 = TextEditingController();
  final cityController2 = TextEditingController();
  final governorateController2 = TextEditingController();
  final schoolNameController3 = TextEditingController();
  final cityController3 = TextEditingController();
  final governorateController3 = TextEditingController();
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                RegistrationAppBare(title: 'المدارس التي درست بها'),
                Text(
                  'المدرسة الابتدائية',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                TextInput(
                  controller: schoolNameController1,
                  labelText: 'اسم المدرسة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: cityController1,
                  labelText: 'المدينة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: governorateController1,
                  labelText: 'المحافظة',
                ),
                sizedBoxMedium,
                Text(
                  'المدرسة الإعدادية',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                TextInput(
                  controller: schoolNameController2,
                  labelText: 'اسم المدرسة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: cityController2,
                  labelText: 'المدينة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: governorateController2,
                  labelText: 'المحافظة',
                ),
                sizedBoxMedium,
                Text(
                  'المدرسة الثانوية',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                TextInput(
                  controller: schoolNameController3,
                  labelText: 'اسم المدرسة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: cityController3,
                  labelText: 'المدينة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: governorateController3,
                  labelText: 'المحافظة',
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
                          final schools = [
                            School(
                              id: generateRandomString(10),
                              name: schoolNameController1.text,
                              studyLevel: StudyLevel.primary,
                              city: cityController1.text,
                              province: governorateController1.text,
                            ),
                            School(
                              id: generateRandomString(12),
                              name: schoolNameController2.text,
                              studyLevel: StudyLevel.middle,
                              city: cityController2.text,
                              province: governorateController2.text,
                            ),
                            School(
                              id: generateRandomString(15),
                              name: schoolNameController3.text,
                              studyLevel: StudyLevel.highe,
                              city: cityController3.text,
                              province: governorateController3.text,
                            )
                          ];
                          context.read<RegistrationProvider>().student =
                              context.read<RegistrationProvider>().student.copyWith(
                                    schools: schools,
                                  );
                          print(context.read<RegistrationProvider>().student);
                          Navigator.of(context).pushNamed(HighSchoolSertificat.routeName);
                        })),
                sizedBoxSmall,
              ]),
            ),
          ),
        ),
      ),
    );
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    final values = List.generate(length, (index) => chars[random.nextInt(chars.length)]);
    return values.join();
  }
}
