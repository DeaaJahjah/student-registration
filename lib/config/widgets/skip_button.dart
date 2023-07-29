import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class SkipButton extends StatelessWidget {
  final void Function()? onTap;
  const SkipButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          decoration: const BoxDecoration(
              color: secondaryColor,
              boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
          child: Text(
            'تخطي',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
