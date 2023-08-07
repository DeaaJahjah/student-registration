// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as String,
      name: json['name'] as String,
      studyLevel: $enumDecode(_$StudyLevelEnumMap, json['study_level']),
      city: json['city'] as String,
      province: json['province'] as String,
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'study_level': _$StudyLevelEnumMap[instance.studyLevel]!,
      'city': instance.city,
      'province': instance.province,
    };

const _$StudyLevelEnumMap = {
  StudyLevel.primary: 'primary',
  StudyLevel.middle: 'middle',
  StudyLevel.highe: 'highe',
};
