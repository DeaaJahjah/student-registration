import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class UnderLineText extends StatelessWidget {
  const UnderLineText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: primaryColor,
              decorationThickness: 4.0,
            ));
  }
}
