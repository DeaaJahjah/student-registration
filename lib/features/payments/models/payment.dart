import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(explicitToJson: true)
class Payment extends Equatable {
  final String? paymentNumber;
  final DateTime? dateTime;
  final double? amount;

  const Payment({this.dateTime, required this.amount, this.paymentNumber});

  Payment copyWith({DateTime? dateTime, double? amount, String? paymentNumber}) {
    return Payment(
        dateTime: dateTime ?? this.dateTime,
        amount: amount ?? this.amount,
        paymentNumber: paymentNumber ?? this.paymentNumber);
  }

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  factory Payment.fromFirestore(DocumentSnapshot documentSnapshot) {
    Payment payment = Payment.fromJson(documentSnapshot.data() as Map<String, dynamic>);

    return payment;
  }

  @override
  List<Object?> get props => [dateTime, amount, paymentNumber];
}
