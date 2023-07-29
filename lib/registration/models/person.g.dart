// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String,
      name: json['name'] as String?,
      work: json['work'] as String?,
      address: json['address'] as String?,
      maritalStatus:
          $enumDecode(_$MaritalStatusEnumMap, json['marital_status']),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'work': instance.work,
      'address': instance.address,
      'marital_status': _$MaritalStatusEnumMap[instance.maritalStatus]!,
    };

const _$MaritalStatusEnumMap = {
  MaritalStatus.single: 'single',
  MaritalStatus.married: 'married',
};
