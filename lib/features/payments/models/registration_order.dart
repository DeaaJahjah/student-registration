import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/features/payments/models/payment.dart';

part 'registration_order.g.dart';

@JsonSerializable(explicitToJson: true)
class RegistrationOrder extends Equatable {
  final String id;
  final String year;
  final String acceptencType;
  final String studyState;
  final RegistrationType registrationType;
  final int numberOfPayments;
  final bool isCompleted;
  final DateTime createdAt;
  final double? annulFees;
  final double registrationFees;

  final List<Payment> payments;

  const RegistrationOrder(
      {required this.id,
      required this.year,
      required this.acceptencType,
      required this.studyState,
      required this.registrationType,
      required this.numberOfPayments,
      required this.isCompleted,
      required this.payments,
      required this.annulFees,
      required this.registrationFees,
      required this.createdAt});

  RegistrationOrder copyWith(
      {String? id,
      String? year,
      String? acceptencType,
      String? studyState,
      RegistrationType? registrationType,
      int? numberOfPayments,
      bool? isCompleted,
      double? annulFees,
      double? registrationFees,
      List<Payment>? payments,
      DateTime? createdAt}) {
    return RegistrationOrder(
      id: id ?? this.id,
      year: year ?? this.year,
      annulFees: annulFees ?? this.annulFees,
      registrationFees: registrationFees ?? this.registrationFees,
      acceptencType: acceptencType ?? this.acceptencType,
      studyState: studyState ?? this.studyState,
      registrationType: registrationType ?? this.registrationType,
      numberOfPayments: numberOfPayments ?? this.numberOfPayments,
      isCompleted: isCompleted ?? this.isCompleted,
      payments: payments ?? this.payments,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory RegistrationOrder.fromJson(Map<String, dynamic> json) => _$RegistrationOrderFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationOrderToJson(this);

  factory RegistrationOrder.fromFirestore(DocumentSnapshot documentSnapshot) {
    RegistrationOrder registrationOrder = RegistrationOrder.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    registrationOrder = registrationOrder.copyWith(id: documentSnapshot.id);

    return registrationOrder;
  }

  @override
  List<Object?> get props => [
        id,
        year,
        acceptencType,
        studyState,
        registrationType,
        numberOfPayments,
        annulFees,
        registrationFees,
      ];
}
