import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/individuals_num_drop_down.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';

class WifeInfo extends StatefulWidget {
  const WifeInfo({Key? key}) : super(key: key);

  @override
  State<WifeInfo> createState() => _WifeInfoState();
}

class _WifeInfoState extends State<WifeInfo> {
  final nameController = TextEditingController();
  final nationalityController = TextEditingController();
  final workController = TextEditingController();
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextInput(
        controller: nameController,
        labelText: 'اسم الزوجة',
        onChanged: (value) {
          context.read<RegistrationProvider>().student = context.read<RegistrationProvider>().student.copyWith(
                wifeName: value,
              );
        },
      ),
      sizedBoxSmall,
      TextInput(
        controller: nationalityController,
        labelText: 'الجنسية',
        onChanged: (value) {
          context.read<RegistrationProvider>().student = context.read<RegistrationProvider>().student.copyWith(
                wifeNationality: value,
              );
        },
      ),
      sizedBoxSmall,
      TextInput(
        controller: workController,
        labelText: 'العمل',
        onChanged: (value) {
          context.read<RegistrationProvider>().student = context.read<RegistrationProvider>().student.copyWith(
                wifeJob: value,
              );
        },
      ),
      sizedBoxLarge,
      Text(
        'عدد الأولاد',
        style: Theme.of(context).textTheme.displayLarge,
      ),
      IndividualsNumDropDown(
        value: value,
        onChanged: (selectedValue) {
          setState(() {
            value = selectedValue!;
            context.read<RegistrationProvider>().student = context.read<RegistrationProvider>().student.copyWith(
                  childrenNumber: value,
                );
            context.read<RegistrationProvider>().student.childrenNames = List.filled(value, null);
          });
        },
      ),
      sizedBoxSmall,
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: value,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextInput(
            controller: TextEditingController(text: context.read<RegistrationProvider>().student.childrenNames![index]),
            labelText: 'اسم الولد ${individualsNum[index]}',
            onChanged: (value) {
              print(context.read<RegistrationProvider>().student.childrenNames);
              context.read<RegistrationProvider>().student.childrenNames![index] = value;
            },
          ),
        ),
      ),
      sizedBoxSmall,
    ]);
  }
}
