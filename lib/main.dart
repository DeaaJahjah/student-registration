import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_registeration_system/admin/admin_app.dart';
import 'package:student_registeration_system/app.dart';
import 'package:student_registeration_system/config/utils/shared_pref.dart';
import 'package:student_registeration_system/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(!kIsWeb ? const MyApp() : const AdminApp());
}
