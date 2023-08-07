import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/super_admin/models/fee.dart';
import 'package:student_registeration_system/admin/super_admin/services/registration_fees_db_service.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/utils/transate_enums.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';

class RegistrationFeeCard extends StatelessWidget {
  RegistrationFeeCard({
    super.key,
    required this.fee,
  });
  Fee fee;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getStudyState(fee.studyState),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: secondaryColor),
        ),
        TextInput(
          controller: TextEditingController(text: fee.cost.toString()),
          labelText: 'الرسم',
          onChanged: (p0) => fee = fee.copyWith(cost: double.tryParse(p0)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 200, top: 8.0),
          child: ButtonWithShadow(
              text: 'حفظ',
              onTap: () async {
                await RegistrationFeesDbService().updateRegistrationFees(context, fee);
              }),
        )
      ],
    );
  }
}
