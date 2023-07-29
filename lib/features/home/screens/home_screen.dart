import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/features/home/widgets/home_body.dart';

import '../../../registration/providers/registration_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => context.read<RegistrationProvider>().getStudent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          const CustomAppBar(
            iconName: 'notification',
            title: 'الرئيسية',
          ),
          Image.asset('assets/images/banner.png'),
          const HomeBody(),
          Text(
            '''
سوف يتم تفعيل التسجيل على السنة الجديدة بعد اجتياز
 الامتحانات الفصلية والترفع إلى السنة التالية
''',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
