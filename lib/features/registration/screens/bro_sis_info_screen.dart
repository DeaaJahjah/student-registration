import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/widgets/bro_sis_ino_widget.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/individuals_num_drop_down.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/features/registration/screens/schools_info.dart';

import '../models/person.dart';
import '../providers/registration_provider.dart';

class BroAndSisInfo extends StatefulWidget {
  static const routeName = '/h';
  const BroAndSisInfo({Key? key}) : super(key: key);

  @override
  State<BroAndSisInfo> createState() => _BroAndSisInfoState();
}

class _BroAndSisInfoState extends State<BroAndSisInfo> {
  final _key = GlobalKey<FormState>();
  int selectedValue = 0;
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
                RegistrationAppBare(title: ' الأخوة والأخوات'),
                sizedBoxSmall,
                Text(
                  'عدد الأخوة و الأخوات',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                IndividualsNumDropDown(
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;

                      // ignore: unnecessary_cast
                      context.read<RegistrationProvider>().student.sistersBrothers = List.generate(
                              value,
                              (g) =>
                                  Person(id: '', address: '', name: '', work: '', maritalStatus: MaritalStatus.single))
                          as List<Person>?;
                    });
                  },
                  value: selectedValue,
                ),
                sizedBoxSmall,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: selectedValue,
                  itemBuilder: (context, index) => BroSisInfoWidget(
                    index: index,
                  ),
                ),
                Center(
                    child: ButtonWithShadow(
                  text: 'التالي',
                  onTap: () => Navigator.of(context).pushNamed(SchoolsInfo.routeName),
                )),
                sizedBoxMedium
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
