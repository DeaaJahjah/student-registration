// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificate _$CertificateFromJson(Map<String, dynamic> json) => Certificate(
      id: json['id'] as String,
      type: json['type'] as String,
      major: json['major'] as String,
      successCycle: json['success_cycle'] as String,
      average: (json['average'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'major': instance.major,
      'success_cycle': instance.successCycle,
      'average': instance.average,
      'date': instance.date.toIso8601String(),
    };
