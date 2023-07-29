// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collage _$CollageFromJson(Map<String, dynamic> json) => Collage(
      id: json['id'] as String,
      name: json['name'] as String,
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      annualFees: (json['annual_fees'] as num).toDouble(),
      activeRegistrationForNewYear:
          json['active_registration_for_new_year'] as bool,
    );

Map<String, dynamic> _$CollageToJson(Collage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'annual_fees': instance.annualFees,
      'departments': instance.departments,
      'active_registration_for_new_year': instance.activeRegistrationForNewYear,
    };
