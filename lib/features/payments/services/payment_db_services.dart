import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/payments/models/registration_order.dart';

class PaymentDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final studentId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<RegistrationOrder>> getAllPayments() async {
    List<RegistrationOrder> orders = [];
    var query = await _db
        .collection('students')
        .doc(studentId)
        .collection('registrationOrders')
        .orderBy('createdAt', descending: true)
        .get();

    for (var doc in query.docs) {
      var order = RegistrationOrder.fromFirestore(doc);

      for (var payment in order.payments) {
        orders.add(RegistrationOrder(
            id: 'الدفعة ${payment.paymentNumber}',
            year: order.year,
            acceptencType: order.acceptencType,
            studyState: order.studyState,
            registrationType: order.registrationType,
            numberOfPayments: order.numberOfPayments,
            isCompleted: order.isCompleted,
            payments: order.payments,
            annulFees: payment.amount,
            registrationFees: payment.amount!,
            createdAt: payment.dateTime!));
      }
    }
    return orders;
  }

  Future<List<RegistrationOrder>> getLastPayment() async {
    List<RegistrationOrder> orders = [];
    var query = await _db
        .collection('students')
        .doc(studentId)
        .collection('registrationOrders')
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    for (var doc in query.docs) {
      orders.add(RegistrationOrder.fromFirestore(doc));
    }
    return orders;
  }

  Future<List<RegistrationOrder>> getLastPaymentByDate({required String id}) async {
    List<RegistrationOrder> orders = [];
    var query = await _db
        .collection('students')
        .doc(studentId)
        .collection('registrationOrders')
        .where('id', isEqualTo: id)
        .where('isCompleted', isEqualTo: false)
        .limit(1)
        .get();

    for (var doc in query.docs) {
      final order = RegistrationOrder.fromFirestore(doc);
      // if (order.createdAt.month == date.month) {
      orders.add(RegistrationOrder.fromFirestore(doc));
      // }
    }
    return orders;
  }

  Future<RegistrationOrder?> getLastPaymentByStudentId({required String studentId}) async {
    RegistrationOrder? order;
    var query = await _db
        .collection('students')
        .doc(studentId)
        .collection('registrationOrders')
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    for (var doc in query.docs) {
      order = RegistrationOrder.fromFirestore(doc);
      print('${order.id}    id');
    }
    return order;
  }

  Future<bool> makePayment(BuildContext context, RegistrationOrder order) async {
    try {
      var query = await _db
          .collection('students')
          .doc(studentId)
          .collection('registrationOrders')
          .doc(order.id)
          .update(order.toJson());

      showSuccessSnackBar(context, 'تمت عملية الدفع بنجاح');

      return true;
    } catch (e) {
      showErrorSnackBar(context, 'حدث خطأ اثناء عملية الدفع');
      return false;
    }
  }

  Future<void> updatePayment(BuildContext context, RegistrationOrder order, String studentId) async {
    var query = await _db
        .collection('students')
        .doc(studentId)
        .collection('registrationOrders')
        .doc(order.id)
        .update(order.toJson());
  }
}
