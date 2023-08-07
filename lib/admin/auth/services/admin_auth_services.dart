import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/admin_home/screens/admin_home_screen.dart';
import 'package:student_registeration_system/admin/auth/admin_login.dart';
import 'package:student_registeration_system/admin/super_admin/screens/super_admin_home_screen.dart';

class AdminAuthDbServics {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    // await streamSdk.StreamChatCore.of(context).client.disconnectUser();
    Navigator.of(context).pushReplacementNamed(AdminLogin.routeName);
  }

  Future<UserCredential?> signIn(
      {required String email, required String password, required BuildContext context}) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (credential.user!.email == 'super.admin@gmail.com') {
        Navigator.of(context).pushReplacementNamed(SuperAdminHomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
      print(e.message);
    }
    return null;
  }
}
