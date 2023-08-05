import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/features/home/widgets/home_body.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';

import '../../../registration/providers/registration_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loadingCollageId = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<RegistrationProvider>().getStudent().then((value) {
        setState(() {
          loadingCollageId = false;
        });
      });
      NotificationDbService().showNotification();
    });
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
          HomeBody(loadingCollageId: loadingCollageId),
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
