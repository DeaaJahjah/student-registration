// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      amount: (json['amount'] as num?)?.toDouble(),
      paymentNumber: json['paymentNumber'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'paymentNumber': instance.paymentNumber,
      'dateTime': instance.dateTime?.toIso8601String(),
      'amount': instance.amount,
    };
