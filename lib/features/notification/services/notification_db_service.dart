import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_service.dart';

class NotificationDbService {
  final NotificationService _notificationService = NotificationService();
  var user = FirebaseAuth.instance.currentUser;
  int unReaded = 0;

  Future<void> sendNotification({required String studentId, required NotificationModle notification}) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .collection('notifications')
        .add(notification.toJson());
  }

  showNotification() {
    FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .snapshots()
        .listen((event) async {
      var docs = event.docs;

      for (var doc in docs) {
        var data = doc.data();
        await _notificationService.showNotifications(
            id: DateTime.now().millisecond, title: data['title'], body: data['body'], pauload: '/notification');
      }
    });
  }

  //get unreaded notifications realtime
  Stream<int> getUnreadedNotifications() {
    return FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }

  Future<List<NotificationModle>> getNotifications() async {
    List<NotificationModle> notifications = [];
    print(user!.uid);
    final query = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .collection('notifications')
        .orderBy('created_at', descending: true)
        .get();

    for (var doc in query.docs) {
      notifications.add(NotificationModle.fromFirestore(doc));
    }
    return notifications;
  }

  List<NotificationModle> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data.call());
      return NotificationModle.fromFirestore(doc);
    }).toList();
  }

  addNotification(NotificationModle notificationModle) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .collection('notifications')
        .add(notificationModle.toJson());
  }

  makeNotificationAsReaded() async {
    var query = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .collection('notifications')
        .where('is_readed', isEqualTo: false)
        .get();
    List<NotificationModle> notification = [];
    for (var doc in query.docs) {
      var noti = NotificationModle.fromFirestore(doc);
      noti.isReaded = true;
      notification.add(noti);
    }
    for (var noti in notification) {
      FirebaseFirestore.instance
          .collection('students')
          .doc(user!.uid)
          .collection('notifications')
          .doc(noti.notificationId)
          .update(noti.toJson());
    }
  }
}
