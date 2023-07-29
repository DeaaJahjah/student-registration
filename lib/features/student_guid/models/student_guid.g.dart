// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_guid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentGuid _$StudentGuidFromJson(Map<String, dynamic> json) => StudentGuid(
      id: json['id'] as String,
      title: json['title'] as String,
      path: json['path'] as String,
      requiredDocs: json['required_docs'] as String,
      fees: (json['fees'] as num).toDouble(),
      link: json['link'] as String?,
    );

Map<String, dynamic> _$StudentGuidToJson(StudentGuid instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'path': instance.path,
      'required_docs': instance.requiredDocs,
      'fees': instance.fees,
      'link': instance.link,
    };
