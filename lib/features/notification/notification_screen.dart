import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/features/ads/screens/ads_screen.dart';

import 'package:student_registeration_system/features/notification/model/notification_model.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/features/payments/screens/complet_fees_screen.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  updateNotification() async {
    await NotificationDbService().makeNotificationAsReaded();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => updateNotification());
    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(
            iconName: 'back',
            title: 'الاشعارت',
            onTap: () => Navigator.of(context).pop(),
          ),
          FutureBuilder<List<NotificationModle>>(
            future: NotificationDbService().getNotifications(),
            builder: (context, snapshot) {
              print(snapshot.data);

              if (snapshot.hasData) {
                List<NotificationModle> notifications = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      var notification = notifications[index];
                      return InkWell(
                        onTap: () async {
                          ///? check task Type
                          if (notification.type == NotificationType.ad) {
                            Navigator.of(context).pushNamed(AdsScreen.routeName);
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: primaryColor)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  notification.body,
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: primaryColor),
                                ),
                                if (notification.type == NotificationType.completeFees)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(CompletFeesScreen.routeName, arguments: notification.orderId);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                                          decoration: const BoxDecoration(color: primaryColor, boxShadow: [
                                            BoxShadow(
                                                offset: Offset(-2, 2),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                color: Colors.black54)
                                          ]),
                                          child: Text(
                                            'ادفع',
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            )),
                      );
                    });
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
