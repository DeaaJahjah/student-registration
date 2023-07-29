import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class SideButton extends StatelessWidget {
  const SideButton(
      {super.key, required this.isSelected, required this.title, required this.index, required this.onTap});

  final bool isSelected;
  final String title;
  final int index;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          title,
          style:
              Theme.of(context).textTheme.headlineMedium!.copyWith(color: isSelected ? primaryColor : secondaryColor),
        ),
      ),
    );
  }
}
