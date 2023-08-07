import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';

class StudentGuidDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<StudentGuid>> getStudentGuid() async {
    List<StudentGuid> guids = [];
    var query = await _db.collection('studentsGuid').get();

    for (var doc in query.docs) {
      guids.add(StudentGuid.fromFirestore(doc));
    }
    return guids;
  }

  Future<bool> deleteGuid(context, String id) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('studentsGuid').doc(id).delete();
      Navigator.pop(context);
      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم حذف الاعلان بنجاح',
        autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {
          Navigator.pop(context);

          // Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
        },
      );
      return true;
    } catch (e) {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/error.gif',
        type: QuickAlertType.error,
        text: 'حدث خطأ',
      );
      return false;
    }
  }

  Future<bool> addGuid(context, StudentGuid guid) async {
    try {
      await _db.collection('studentsGuid').add(guid.toJson());
      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
        // text: 'تم اضافة الدليل بنجاح',
        // autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {
          Navigator.pop(context);

          // Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
        },
      );
      Navigator.pop(context);
      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم اضافة الدليل بنجاح',
        autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {
          Navigator.pop(context);

          // Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
        },
      );
      return true;
    } catch (e) {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/error.gif',
        type: QuickAlertType.error,
        text: 'حدث خطأ',
      );
      return false;
    }
  }

  Future<bool> updateGuid(context, StudentGuid guid) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('studentsGuid').doc(guid.id).update(guid.toJson());
      Navigator.pop(context);
      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم تعديل الدليل بنجاح',
        autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {
          Navigator.pop(context);

          // Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
        },
      );
      return true;
    } catch (e) {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/error.gif',
        type: QuickAlertType.error,
        text: 'حدث خطأ',
      );
      return false;
    }
  }
}
