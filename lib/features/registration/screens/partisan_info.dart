import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/skip_button.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/screens/addtional_info.dart';

import '../providers/registration_provider.dart';

class PartisanInfo extends StatefulWidget {
  static const routeName = '/partisan_info';
  const PartisanInfo({Key? key}) : super(key: key);

  @override
  State<PartisanInfo> createState() => _PartisanInfoState();
}

class _PartisanInfoState extends State<PartisanInfo> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final numController = TextEditingController();
  final characterController = TextEditingController();
  DateTime? date = DateTime.now();
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
              RegistrationAppBare(title: 'المعلومات الحزبية'),
              sizedBoxSmall,
              TextInput(
                controller: nameController,
                labelText: 'اسم الحزب',
              ),
              sizedBoxSmall,
              TextInput(
                controller: dateController,
                labelText: 'تاريخ الانتساب',
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
                  if (date != null) {
                    dateController.text = ('${date!.year}-${date!.month}-${date!.day}').toString();
                  }
                },
              ),
              sizedBoxSmall,
              TextInput(
                controller: numController,
                labelText: 'الرقم الحزبي',
                keyboardType: TextInputType.number,
              ),
              sizedBoxSmall,
              TextInput(
                controller: characterController,
                labelText: 'الصفة الحزبية',
              ),
              sizedBoxLarge,
              Center(
                  child: ButtonWithShadow(
                      text: 'التالي',
                      onTap: () {
                        context.read<RegistrationProvider>().student =
                            context.read<RegistrationProvider>().student.copyWith(
                                  partisanName: nameController.text,
                                  partisanCharacter: characterController.text,
                                  partisanDate: date,
                                  partisanNumber: int.tryParse(numController.text),
                                );
                        Navigator.of(context).pushNamed(AddtionalInfo.routeName);
                      })),
              sizedBoxSmall,
              SkipButton(
                onTap: () => Navigator.of(context).pushNamed(AddtionalInfo.routeName),
              ),
              sizedBoxSmall,
            ]),
          ),
        ),
      ),
    ));
  }
}
