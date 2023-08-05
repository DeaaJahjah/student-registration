import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModle {
  //get it from document id
  @JsonKey(name: 'notification_id')
  String? notificationId;
  final String title;
  final String body;
  @JsonKey(name: 'is_readed')
  bool isReaded;
  final String pauload;
  final NotificationType type;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  NotificationModle(
      {this.notificationId,
      required this.title,
      required this.body,
      required this.isReaded,
      required this.pauload,
      required this.type,
      required this.createdAt});

  factory NotificationModle.fromJson(Map<String, dynamic> json) => _$NotificationModleFromJson(json);

  factory NotificationModle.fromFirestore(DocumentSnapshot documentSnapshot) {
    final map = Map<String, dynamic>.from(documentSnapshot.data() as Map);
    print(map.runtimeType);
    NotificationModle notification = NotificationModle.fromJson(map);
    notification.notificationId = documentSnapshot.id;
    return notification;
  }

  Map<String, dynamic> toJson() => _$NotificationModleToJson(this);
}
