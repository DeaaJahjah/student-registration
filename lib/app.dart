import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/routes/router.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/features/home/screens/home_screen.dart';
import 'package:student_registeration_system/features/notification/services/navigation_service.dart';
import 'package:student_registeration_system/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    // auth.signOut();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RegistrationProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          navigatorKey: GlobalVariable.navState,
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
          home: auth.currentUser != null ? const HomeScreen() : const SplashScreen()),
    );
  }
}
