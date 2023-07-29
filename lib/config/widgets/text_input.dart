import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/validetors.dart';

class TextInput extends StatelessWidget {
  // final String icon;
  final String labelText;
  final TextEditingController controller;
  TextInputType? keyboardType;
  int? maxLines = 1;
  int? minLines;
  bool? readOnly = false;
  final Function()? onTap;
  void Function(String)? onChanged;
  bool isRequired;
  TextInput(
      {super.key,
      required this.labelText,
      required this.controller,
      this.keyboardType,
      this.maxLines,
      this.minLines,
      this.onTap,
      this.onChanged,
      this.isRequired = true,
      this.readOnly});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: primaryColor),
            color: white,
            boxShadow: const [BoxShadow(offset: Offset(-3, 2), blurRadius: 4, color: primaryColor)]),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: primaryColor, fontFamily: font),
          maxLines: maxLines,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          minLines: minLines,
          validator: isRequired ? requiredField : null,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.displayMedium,
          ),
          onTap: onTap,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
