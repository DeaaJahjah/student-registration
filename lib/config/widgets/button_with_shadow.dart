import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class ButtonWithShadow extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ButtonWithShadow({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: primaryColor,
            boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
