import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/widgets/maritalstatus_drop_down.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';

class BroSisInfoWidget extends StatefulWidget {
  final int index;
  const BroSisInfoWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<BroSisInfoWidget> createState() => _BroSisInfoWidgetState();
}

class _BroSisInfoWidgetState extends State<BroSisInfoWidget> {
  final nameController = TextEditingController();
  final serialNumberController = TextEditingController();
  final workController = TextEditingController();
  final addressController = TextEditingController();
  var maritalstatus = MaritalStatus.married;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(individualsNum[widget.index], style: Theme.of(context).textTheme.displayLarge),
      TextInput(
        controller: nameController,
        labelText: 'الاسم',
        onChanged: (value) {
          context.read<RegistrationProvider>().student.sistersBrothers![widget.index].name = value;
        },
      ),
      sizedBoxSmall,
      TextInput(
        controller: serialNumberController,
        labelText: 'الرقم التسلسلي',
        keyboardType: TextInputType.number,
        onChanged: (value) {
          context.read<RegistrationProvider>().student.sistersBrothers![widget.index].id = value;
        },
      ),
      sizedBoxSmall,
      TextInput(
        controller: workController,
        labelText: 'العمل',
        onChanged: (value) {
          context.read<RegistrationProvider>().student.sistersBrothers![widget.index].work = value;
        },
      ),
      sizedBoxSmall,
      TextInput(
        controller: addressController,
        labelText: 'مكان الإقامة',
        onChanged: (value) {
          context.read<RegistrationProvider>().student.sistersBrothers![widget.index].address = value;
        },
      ),
      sizedBoxSmall,
      MaritalstatusDropDown(
        value: maritalstatus,
        onChanged: (value) {
          setState(() {
            maritalstatus = value!;
          });
          context.read<RegistrationProvider>().student.sistersBrothers![widget.index].maritalStatus = value!;
        },
      ),
      sizedBoxLarge,
    ]);
  }
}
