import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: secondaryColor,
    ));
  }
}
