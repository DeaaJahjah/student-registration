import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/features/home/widgets/home_body.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/features/registration/services/student_db_services.dart';
import 'package:student_registeration_system/splash_screen.dart';

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
    Future.delayed(Duration.zero, () async {
      await context.read<RegistrationProvider>().getStudent().then((value) {
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
    var auth = FirebaseAuth.instance;
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
          !loadingCollageId
              ? StreamBuilder(
                  stream: StudentsDbService().checkRegisterIsActive(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CustomProgress();
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(snapshot.error.toString(),
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
                    }
                    if (snapshot.hasData) {
                      return snapshot.data!.data()!['active_registration_for_new_year']
                          ? const CategoreCard(
                              index: 3,
                            )
                          : const SizedBox.shrink();
                    }
                    return const SizedBox.shrink();
                  })
              : const CustomProgress(),
          InkWell(
            onTap: () async {
              await auth.signOut();

              Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: white,
                  boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
              height: 80,
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 80,
                    width: 10,
                    color: secondaryColor,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'تسجيل خروج',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              ]),
            ),
          ),
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
