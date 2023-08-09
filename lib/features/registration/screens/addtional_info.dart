import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/skip_button.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/screens/verfiy_phone_number_screen.dart';

import '../providers/registration_provider.dart';

class AddtionalInfo extends StatefulWidget {
  static const routeName = '/addtional_info';
  const AddtionalInfo({Key? key}) : super(key: key);

  @override
  State<AddtionalInfo> createState() => _AddtionalInfoState();
}

class _AddtionalInfoState extends State<AddtionalInfo> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final clubsController = TextEditingController();
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
              RegistrationAppBare(title: 'معلومات إضافية'),
              sizedBoxSmall,
              TextInput(
                controller: nameController,
                labelText: 'الألعاب الرياضية التي تمارسها',
                maxLines: 3,
              ),
              sizedBoxSmall,
              TextInput(
                controller: dateController,
                labelText: 'البلدان العربية والأجنبية التي سافرة إليها\n والمدة التي قضيتها بها',
                maxLines: 3,
              ),
              sizedBoxSmall,
              TextInput(
                controller: clubsController,
                labelText: 'النوادي والهيئات والجمهيات التي انتسبت إليها',
                maxLines: 3,
              ),
              sizedBoxLarge,
              Center(
                  child: ButtonWithShadow(
                text: 'التالي',
                onTap: () {
                  context.read<RegistrationProvider>().student = context.read<RegistrationProvider>().student.copyWith(
                        sportGames: nameController.text,
                        countriesYouTravled: dateController.text,
                        clubsOrgs: clubsController.text,
                        accountState: AccountState.pending,
                        studyState: StudyState.newStudent,
                        studyYear: 'الأولى',
                        acceptanceType: AcceptanceType.general,
                      );
                  Navigator.of(context).pushNamed(VerfiyPhoneNumberScree.routeName);
                },
              )),
              sizedBoxSmall,
              SkipButton(onTap: () {
                Navigator.of(context).pushNamed(VerfiyPhoneNumberScree.routeName);
              }),
              sizedBoxSmall,
            ]),
          ),
        ),
      ),
    ));
  }
}
