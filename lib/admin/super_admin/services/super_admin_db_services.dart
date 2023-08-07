import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class SuperAdminDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final adminId = FirebaseAuth.instance.currentUser!.uid;

  Future<bool> updateRegistrationState(BuildContext context, bool value) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );

      await _db.collection('superAdmin').doc(adminId).update({'active_registration_for_new_students': value});

      Navigator.pop(context);

      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم العملية بنجاح',
        autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {},
      );
    } catch (e) {
      Navigator.pop(context);
      print(e.toString());
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/error.gif',
        type: QuickAlertType.error,
        text: 'حدث خطأ',
      );
    }

    return false;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getRegsterationState(BuildContext context) {
    try {
      return _db.collection('superAdmin').doc(adminId).snapshots();

      // return doc.data()!['active_registration_for_new_year'];
      // final collage = Collage.fromFirestore(doc);

      // return collage.activeRegistrationForNewYear;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
