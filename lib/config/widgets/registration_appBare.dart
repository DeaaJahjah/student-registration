import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class RegistrationAppBare extends StatelessWidget {
  String title;
  RegistrationAppBare({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(color: primaryColor, fontFamily: font, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Image.asset(
          'assets/images/appare logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
