import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/admin/admin_home/screens/admin_home_screen.dart';
import 'package:student_registeration_system/admin/admin_home/screens/student_dashboard_screen.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/utils/transate_enums.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/features/registration/models/student.dart';
import 'package:student_registeration_system/splash_screen.dart';
import '../providers/registration_provider.dart';

class StudentsDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<List<Student>> getStudents({required AccountState accountState}) async {
    List<Student> students = [];
    var query = await _db
        .collection('students')
        .where('collage_id', isEqualTo: firebaseUser!.uid)
        .where('accountState', isEqualTo: accountState.name)
        .get();
    print(firebaseUser!.uid);
    for (var doc in query.docs) {
      final student = Student.fromFirestore(doc);
      print(accountState);
      students.add(student);

      // if (accountState == AccountState.pending) {
      //   if (student.accountState == AccountState.pending) {
      //   }
      // } else if (student.accountState != AccountState.pending) {
      //   students.add(student);
      // }
    }
    print(students.length);
    return students;
  }

  creatUser({required Student student, required context}) async {
    try {
      int studentId = await _getStudentsNumbersPlusOne(student.collageId!);
      student = student.copyWith(studentId: studentId.toString());
      await _db.collection('students').doc(firebaseUser!.uid).set(student.toJson());
      showSuccessSnackBar(context, 'تمت عملية التسجيل بنجاح');
      Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<Student?> getStudentById(String? id) async {
    print(firebaseUser!.uid);
    var doc = await _db.collection('students').doc(id ?? firebaseUser!.uid).get();
    if (doc.exists) {
      return Student.fromFirestore(doc);
    }

    return null;
  }

  Future<int> _getStudentsNumbersPlusOne(String collageID) async {
    List<Student> students = [];
    var query = await _db.collection('students').where('collage_id', isEqualTo: collageID).get();

    for (var doc in query.docs) {
      students.add(Student.fromFirestore(doc));
    }

    return students.length + 1;
  }

  Future<bool> updateAccountState(BuildContext context, String id, AccountState accountState) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('students').doc(id).update({'accountState': accountState.name});
      await NotificationDbService().sendNotification(
          studentId: id,
          notification: NotificationModle(
            title: 'تنبيه',
            body: 'تم ${getAccountState(accountState)} حسابك',
            isReaded: false,
            pauload: 'notifications',
            type: NotificationType.normal,
            createdAt: DateTime.now(),
          ));
      Navigator.pop(context);

      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم قبول الطالب بنجاح',
        autoCloseDuration: const Duration(seconds: 2),
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AdminHomeScreen()));
          // Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
        },
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AdminHomeScreen()));
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);

      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/error.gif',
        type: QuickAlertType.error,
        text: 'حدث خطأ',
      );
    }

    return false;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? checkRegisterIsActive(BuildContext context) {
    try {
      return _db.collection('colleges').doc(context.read<RegistrationProvider>().student.collageId).snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> checkAccountStatus(BuildContext context) async {
    var doc = await _db.collection('students').doc(firebaseUser!.uid).get();
    if (doc.exists) {
      final student = Student.fromFirestore(doc);

      switch (student.accountState!) {
        case AccountState.active:
          return 'مفعل';
        case AccountState.pending:
          return 'معلق';

        case AccountState.frozen:
          return 'مجمد';
      }
    }
    return '';
  }
}
