// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationOrder _$RegistrationOrderFromJson(Map<String, dynamic> json) =>
    RegistrationOrder(
      id: json['id'] as String,
      year: json['year'] as String,
      acceptencType: json['acceptencType'] as String,
      studyState: json['studyState'] as String,
      registrationType:
          $enumDecode(_$RegistrationTypeEnumMap, json['registrationType']),
      numberOfPayments: json['numberOfPayments'] as int,
      isCompleted: json['isCompleted'] as bool,
      payments: (json['payments'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      annulFees: (json['annulFees'] as num?)?.toDouble(),
      registrationFees: (json['registrationFees'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RegistrationOrderToJson(RegistrationOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'acceptencType': instance.acceptencType,
      'studyState': instance.studyState,
      'registrationType': _$RegistrationTypeEnumMap[instance.registrationType]!,
      'numberOfPayments': instance.numberOfPayments,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'annulFees': instance.annulFees,
      'registrationFees': instance.registrationFees,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };

const _$RegistrationTypeEnumMap = {
  RegistrationType.newStudent: 'newStudent',
  RegistrationType.registerForNewYear: 'registerForNewYear',
};
