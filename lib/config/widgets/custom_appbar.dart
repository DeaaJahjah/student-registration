import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/features/notification/notification_screen.dart';
import 'package:student_registeration_system/features/notification/services/notification_db_service.dart';
import 'package:student_registeration_system/features/registration/services/collage_db_services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onTap, required this.iconName, required this.title});
  final void Function()? onTap;
  final String iconName;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (iconName == 'notification')
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () async {
                      await Navigator.of(context).pushNamed(NotificationScreen.routeName);

                      await NotificationDbService().makeNotificationAsReaded();
                    },
                    child: StreamBuilder<int>(
                        stream: NotificationDbService().getUnreadedNotifications(),
                        builder: (context, snapshot) {
                          return Stack(children: [
                            InkWell(
                                onTap: onTap,
                                child: SvgPicture.asset('assets/icons/$iconName.svg', height: 40, width: 40)),
                            if (snapshot.data != 0)
                              Positioned(
                                  child: CircleAvatar(
                                backgroundColor: secondaryColor,
                                radius: 10,
                                child: Text(snapshot.data.toString()),
                              )),
                          ]);
                        })))
          else
            InkWell(onTap: onTap, child: SvgPicture.asset('assets/icons/$iconName.svg', height: 40, width: 40)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          InkWell(
              onTap: () {
                CollageDbService().updateRegistrationState(context, true);
              },
              child: Image.asset('assets/images/appbar_logo.png', height: 50, width: 50)),
        ],
      ),
    );
  }
}
