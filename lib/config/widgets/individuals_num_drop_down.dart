import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class IndividualsNumDropDown extends StatefulWidget {
  final void Function(int?)? onChanged;
  final int value;
  const IndividualsNumDropDown({Key? key, required this.onChanged, required this.value}) : super(key: key);

  @override
  State<IndividualsNumDropDown> createState() => _IndividualsNumDropDownState();
}

class _IndividualsNumDropDownState extends State<IndividualsNumDropDown> {
  List<DropdownMenuItem<int>>? items = [];
  @override
  void initState() {
    items = List<DropdownMenuItem<int>>.generate(
        10,
        (index) => DropdownMenuItem(
              alignment: Alignment.center,
              value: index,
              child: Text(
                index.toString(),
                // style: Theme.of(context).textTheme.displayMedium,
              ),
            ));
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
        child: DropdownButton<int>(
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
