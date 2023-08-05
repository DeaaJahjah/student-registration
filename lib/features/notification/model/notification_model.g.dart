// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModle _$NotificationModleFromJson(Map<String, dynamic> json) => NotificationModle(
      notificationId: json['notification_id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      isReaded: json['is_readed'] as bool,
      pauload: json['pauload'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationModleToJson(NotificationModle instance) => <String, dynamic>{
      'notification_id': instance.notificationId,
      'title': instance.title,
      'body': instance.body,
      'is_readed': instance.isReaded,
      'pauload': instance.pauload,
      'type': _$NotificationTypeEnumMap[instance.type],
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.completeFees: 'completeFees',
  NotificationType.normal: 'normal',
  NotificationType.ad: 'ad'
};
