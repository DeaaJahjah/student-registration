import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class MaritalstatusDropDown extends StatefulWidget {
  final void Function(MaritalStatus?)? onChanged;
  final MaritalStatus value;
  const MaritalstatusDropDown({Key? key, required this.onChanged, required this.value}) : super(key: key);

  @override
  State<MaritalstatusDropDown> createState() => _MaritalstatusDropDownState();
}

class _MaritalstatusDropDownState extends State<MaritalstatusDropDown> {
  List<DropdownMenuItem<MaritalStatus>>? items = [];
  @override
  void initState() {
    items = [
      const DropdownMenuItem(
        alignment: Alignment.center,
        value: MaritalStatus.married,
        child: Text(
          'متزوج',
          // style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      const DropdownMenuItem(
        alignment: Alignment.center,
        value: MaritalStatus.single,
        child: Text(
          'اعزب',
          // style: Theme.of(context).textTheme.displayMedium,
        ),
      )
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(width: 1, color: primaryColor),
            boxShadow: const [BoxShadow(offset: Offset(-3, 2), blurRadius: 4, color: primaryColor)]),
        child: DropdownButton<MaritalStatus>(
          hint: Text(
            '1',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          style: Theme.of(context).textTheme.headlineLarge,
          borderRadius: const BorderRadius.only(),
          iconSize: 30,
          iconDisabledColor: secondaryColor,
          iconEnabledColor: secondaryColor,
          isExpanded: true,
          elevation: 0,
          value: widget.value,
          items: items,
          onChanged: widget.onChanged,
        ));
  }
}
