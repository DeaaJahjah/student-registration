import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:student_registeration_system/admin/admin_home/screens/student_dashboard_screen.dart';
import 'package:student_registeration_system/admin/admin_home/widgets/side_button.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/registration/services/collage_db_services.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = '/admin-home-screen';

  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        const StudentDashboardScreen(),
        Expanded(
          flex: 2,
          child: Container(
            color: primaryColor,
            height: MediaQuery.of(context).size.height,
            // width: 200,
            child: Column(
              children: [
                Text(
                  '''الجمهورية العربية السورية
            الكلية التطبيقية''',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                sizedBoxLarge,
                SideButton(
                  title: 'الطلاب',
                  index: 0,
                  isSelected: selectedPageIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedPageIndex = 0;
                    });
                  },
                ),
                SideButton(
                  title: 'إعلانات الكلية',
                  index: 1,
                  isSelected: selectedPageIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedPageIndex = 1;
                    });
                  },
                ),
                SideButton(
                  title: 'خدمات',
                  index: 2,
                  isSelected: selectedPageIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedPageIndex = 2;
                    });
                  },
                ),
                StreamBuilder(
                    stream: CollageDbService().getRegsterationState(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(snapshot.error.toString(),
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
                      }
                      if (snapshot.hasData) {
                        print(snapshot.data!);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('فتح التسجيل'),
                            Switch(
                                value: snapshot.data!.data()!['active_registration_for_new_year'],
                                onChanged: (value) async {
                                  QuickAlert.show(
                                      context: context,
                                      customAsset: 'assets/images/confirm.gif',
                                      type: QuickAlertType.confirm,
                                      text: 'هل انت متأكد من ${value ? 'فتح' : 'اغلاق'} التسجيل على السنة الجديدة؟',
                                      confirmBtnText: 'نعم',
                                      cancelBtnText: 'لا',
                                      confirmBtnColor: primaryColor,
                                      onConfirmBtnTap: () async {
                                        Navigator.pop(context);
                                        await CollageDbService().updateRegistrationState(context, value);
                                      });
                                })
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
