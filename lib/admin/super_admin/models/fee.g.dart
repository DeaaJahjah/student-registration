// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fee _$FeeFromJson(Map<String, dynamic> json) => Fee(
      id: json['id'] as String,
      acceptanceType:
          $enumDecode(_$AcceptanceTypeEnumMap, json['acceptance_type']),
      studyState: $enumDecode(_$StudyStateEnumMap, json['study_state']),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'id': instance.id,
      'acceptance_type': _$AcceptanceTypeEnumMap[instance.acceptanceType]!,
      'study_state': _$StudyStateEnumMap[instance.studyState]!,
      'cost': instance.cost,
    };

const _$AcceptanceTypeEnumMap = {
  AcceptanceType.general: 'general',
  AcceptanceType.engineersChildren: 'engineersChildren',
  AcceptanceType.parallel: 'parallel',
};

const _$StudyStateEnumMap = {
  StudyState.newStudent: 'newStudent',
  StudyState.zeroFail: 'zeroFail',
  StudyState.failOnce: 'failOnce',
  StudyState.failTwice: 'failTwice',
};
