import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student_registeration_system/admin/admin_home/screens/admin_home_screen.dart';
import 'package:student_registeration_system/admin/auth/admin_login.dart';
import 'package:student_registeration_system/admin/super_admin/screens/super_admin_home_screen.dart';
import 'package:student_registeration_system/config/routes/router.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    // auth.signOut();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale("ar", "AE"),
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: onGenerateRoute,
      home: auth.currentUser != null
          ? auth.currentUser!.email == 'super.admin@gmail.com'
              ? const SuperAdminHomeScreen()
              : const AdminHomeScreen()
          : const AdminLogin(),
      // home: const AdminHomeScreen(),
    );
  }
}
