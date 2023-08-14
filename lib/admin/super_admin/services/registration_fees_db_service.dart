import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:student_registeration_system/admin/super_admin/models/fee.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

class RegistrationFeesDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final adminId = FirebaseAuth.instance.currentUser!.uid;

  Future<bool> updateRegistrationFees(BuildContext context, Fee fee) async {
    try {
      QuickAlert.show(
        context: context,
        customAsset: 'assets/images/loading.gif',
        type: QuickAlertType.loading,
      );
      await _db.collection('registrationFees').doc(fee.id).update(fee.toJson());

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

  Future<List<Fee>> getRegistrationFees(BuildContext context, AcceptanceType acceptanceType) async {
    List<Fee> fees = [];
    try {
      final query =
          await _db.collection('registrationFees').where('acceptance_type', isEqualTo: acceptanceType.name).get();
      print('-------------------');
      for (var doc in query.docs) {
        print(doc.data());

        fees.add(Fee.fromFirestore(doc));
      }

      return fees;
    } catch (e) {
      print(e.toString());
    }

    return fees;
  }

  createFee() async {
    // await _db.collection('registrationFees').add(
    //     const Fee(id: '', acceptanceType: AcceptanceType.general, studyState: StudyState.newStudent, cost: 10000)
    //         .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.general, studyState: StudyState.failOnce, cost: 15000)
            .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.general, studyState: StudyState.failTwice, cost: 25000)
            .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.general, studyState: StudyState.zeroFail, cost: 12000)
            .toJson());

    //parallel
    // await _db.collection('registrationFees').add(
    //     const Fee(id: '', acceptanceType: AcceptanceType.parallel, studyState: StudyState.newStudent, cost: 10000)
    //         .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.parallel, studyState: StudyState.failOnce, cost: 12000)
            .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.parallel, studyState: StudyState.failTwice, cost: 24000)
            .toJson());

    await _db.collection('registrationFees').add(
        const Fee(id: '', acceptanceType: AcceptanceType.parallel, studyState: StudyState.zeroFail, cost: 7000)
            .toJson());
  }
}
