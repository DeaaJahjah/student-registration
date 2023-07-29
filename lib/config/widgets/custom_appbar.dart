import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onTap, required this.iconName, required this.title});
  final void Function()? onTap;
  final String iconName;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: onTap, child: SvgPicture.asset('assets/icons/$iconName.svg', height: 40, width: 40)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Image.asset('assets/images/appbar_logo.png', height: 50, width: 50),
        ],
      ),
    );
  }
}
