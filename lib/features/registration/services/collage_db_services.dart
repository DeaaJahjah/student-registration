import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/admin/super_admin/services/registration_fees_db_service.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/utils/transate_enums.dart';
import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/features/payments/models/payment.dart';
import 'package:student_registeration_system/features/payments/models/registration_order.dart';
import 'package:student_registeration_system/features/payments/services/payment_db_services.dart';
import 'package:student_registeration_system/features/registration/models/collage.dart';
import 'package:student_registeration_system/features/registration/services/student_db_services.dart';

class CollageDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collgeId = FirebaseAuth.instance.currentUser == null ? '' : FirebaseAuth.instance.currentUser!.uid;

  Future<List<Collage>> getCollages() async {
    List<Collage> collages = [];
    var query = await _db.collection('colleges').get();

    print(query);
    for (var doc in query.docs) {
      collages.add(Collage.fromFirestore(doc));
    }
    return collages;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getRegsterationState(BuildContext context) {
    try {
      return _db.collection('colleges').doc(collgeId).snapshots();
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
      final parallelFess = await RegistrationFeesDbService().getRegistrationFees(context, AcceptanceType.parallel);
      final generalFess = await RegistrationFeesDbService().getRegistrationFees(context, AcceptanceType.general);

      print('students ${students.length}');
      for (var student in students) {
        if (value) {
          final order = RegistrationOrder(
            id: '',
            year: student.studyYear!,
            acceptencType: student.acceptanceType == AcceptanceType.general ? 'عام' : 'موازي',
            studyState: getStudyState(student.studyState!),
            registrationType: RegistrationType.registerForNewYear,
            numberOfPayments: 1,
            isCompleted: false,
            createdAt: DateTime.now(),
            annulFees: student.annualFees,
            registrationFees: student.acceptanceType == AcceptanceType.general
                ? generalFess
                    .firstWhere((element) =>
                        element.acceptanceType == AcceptanceType.general && element.studyState == student.studyState)
                    .cost
                : parallelFess
                    .firstWhere((element) =>
                        element.acceptanceType == AcceptanceType.parallel && element.studyState == student.studyState)
                    .cost,
            payments: const [Payment(dateTime: null, amount: null, paymentNumber: 'الأولى')],
          );
          print(order);
          final ss =
              await _db.collection('students').doc(student.id).collection('registrationOrders').add(order.toJson());
          print(ss);
        }
        await NotificationDbService().sendNotification(
            studentId: student.id!,
            notification: NotificationModle(
              title: 'تم بدأ التسجيل',
              body: value ? 'يرجى تسديد الرسوم السنة ${student.studyYear} قبل انتهاء مدة التسجيل' : 'تم اغلاق التسجيل ',
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

  Future<bool> senCompleteFeesNotification(
    BuildContext context,
  ) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      // await _db.collection('colleges').doc(collgeId).update({'active_registration_for_new_year': value});

      final students = await StudentsDbService().getStudents(accountState: AccountState.active);

      print('students ${students.length}');
      for (var student in students) {
        if (student.acceptanceType == AcceptanceType.parallel) {
          var order = await PaymentDbService().getLastPaymentByStudentId(studentId: student.id!);

          if (order != null) {
            order.payments.add(Payment(amount: (order.annulFees! / 2), paymentNumber: 'الثانية'));

            await PaymentDbService().updatePayment(context, order, student.id!);
            await NotificationDbService().sendNotification(
                studentId: student.id!,
                notification: NotificationModle(
                  title: student.collageName!,
                  body: 'يرجى استكمال الرسوم السنة ${student.studyYear} قبل انتهاء مدة التسجيل',
                  isReaded: false,
                  pauload: 'notifications',
                  type: NotificationType.completeFees,
                  createdAt: DateTime.now(),
                ));
          }
        }
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

  Future<bool> updateCollage(BuildContext context, Collage collage) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      print(collgeId);
      await _db.collection('colleges').doc(collage.id).update(collage.toJson());

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
