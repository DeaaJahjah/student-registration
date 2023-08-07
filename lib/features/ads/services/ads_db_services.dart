import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/features/ads/models/ad.dart';
import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/registration/services/student_db_services.dart';

class AdsDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<List<Ad>> getAds(BuildContext context) async {
    List<Ad> ads = [];
    // final String collageId = SharedPref.load('collage_id');
    var query = await _db
        .collection('colleges')
        .doc(context.read<RegistrationProvider>().student.collageId)
        .collection('ads')
        .get();

    for (var doc in query.docs) {
      ads.add(Ad.fromFirestore(doc));
    }
    return ads;
  }

  //! this is Admin's functions
  Future<List<Ad>> getCollageAds() async {
    List<Ad> ads = [];
    // final String collageId = SharedPref.load('collage_id');
    var query = await _db.collection('colleges').doc(firebaseUser!.uid).collection('ads').get();

    for (var doc in query.docs) {
      ads.add(Ad.fromFirestore(doc));
    }
    return ads;
  }

  Future<bool> deleteAd(context, String id) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('colleges').doc(firebaseUser!.uid).collection('ads').doc(id).delete();
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

  Future<bool> addAd(context, Ad ad) async {
    try {
      await _db.collection('colleges').doc(firebaseUser!.uid).collection('ads').add(ad.toJson());

      final students = await StudentsDbService().getStudents(accountState: AccountState.active);

      for (var student in students) {
        await NotificationDbService().sendNotification(
            studentId: student.id!,
            notification: NotificationModle(
              title: 'اعلان',
              body: ad.text,
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
        text: 'تم اضافة الاعلان بنجاح',
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

  Future<bool> updateAd(context, Ad ad) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('colleges').doc(firebaseUser!.uid).collection('ads').doc(ad.id).update(ad.toJson());
      Navigator.pop(context);
      await QuickAlert.show(
        context: context,
        customAsset: 'assets/images/success.gif',
        type: QuickAlertType.success,
        text: 'تم تعديل الاعلان بنجاح',
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
