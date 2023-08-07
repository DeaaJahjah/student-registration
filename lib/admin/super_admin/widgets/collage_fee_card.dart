import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/models/collage.dart';
import 'package:student_registeration_system/features/registration/services/collage_db_services.dart';

class CollageFeeCard extends StatelessWidget {
  CollageFeeCard({
    super.key,
    required this.collage,
  });
  Collage collage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          collage.name,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: secondaryColor),
        ),
        TextInput(
          controller: TextEditingController(text: collage.annualFees.toString()),
          labelText: 'الرسم',
          onChanged: (p0) => collage = collage.copyWith(annualFees: double.tryParse(p0)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 200, top: 8.0),
          child: ButtonWithShadow(
              text: 'حفظ',
              onTap: () async {
                await CollageDbService().updateCollage(context, collage);
              }),
        )
      ],
    );
  }
}
