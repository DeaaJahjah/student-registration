import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/registration/models/collage.dart';
import 'package:student_registeration_system/registration/services/student_db_services.dart';

class CollageDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collgeId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Collage>> getCollages() async {
    List<Collage> collages = [];
    var query = await _db.collection('colleges').get();

    for (var doc in query.docs) {
      print(doc);
      collages.add(Collage.fromFirestore(doc));
    }
    return collages;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getRegsterationState(BuildContext context) {
    try {
      return _db.collection('colleges').doc(collgeId).snapshots();

      // return doc.data()!['active_registration_for_new_year'];
      // final collage = Collage.fromFirestore(doc);

      // return collage.activeRegistrationForNewYear;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateRegistrationState(BuildContext context, bool value) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      print(collgeId);
      await _db.collection('colleges').doc(collgeId).update({'active_registration_for_new_year': value});

      final students = await StudentsDbService().getStudents(accountState: AccountState.active);

      for (var student in students) {
        await NotificationDbService().sendNotification(
            studentId: student.id!,
            notification: NotificationModle(
              title: 'تسجيل',
              body: value ? 'تم فتح التسجيل إلى السنة الجديد' : 'تم اغلاق التسجيل ',
              isReaded: false,
              pauload: 'notifications',
              type: NotificationType.normal,
              createdAt: DateTime.now(),
            ));
      }
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
}
