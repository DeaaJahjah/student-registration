import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:student_registeration_system/admin/admin_home/screens/manage_ads_screen.dart';
import 'package:student_registeration_system/admin/admin_home/screens/student_dashboard_screen.dart';
import 'package:student_registeration_system/admin/admin_home/widgets/side_button.dart';
import 'package:student_registeration_system/admin/auth/admin_login.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/skip_button.dart';
import 'package:student_registeration_system/features/registration/services/collage_db_services.dart';

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
    // RegistrationFeesDbService().createFee();
    return Scaffold(
      body: Row(children: [
        if (selectedPageIndex == 0) const StudentDashboardScreen(),
        if (selectedPageIndex == 1) const ManageAdsScreen(),
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
                SkipButton(
                    title: 'ارسال اشعار استكمال الرسوم',
                    onTap: () async {
                      QuickAlert.show(
                          context: context,
                          customAsset: 'assets/images/confirm.gif',
                          type: QuickAlertType.confirm,
                          text: ' هل انت متاكد من ارسال اشعار استكمال الرسوم؟',
                          confirmBtnText: 'نعم',
                          cancelBtnText: 'لا',
                          confirmBtnColor: primaryColor,
                          onConfirmBtnTap: () async {
                            Navigator.pop(context);
                            await CollageDbService().senCompleteFeesNotification(context);
                          });
                    }),
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
                    }),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var auth = FirebaseAuth.instance;

                      auth.signOut();

                      Navigator.of(context).pushReplacementNamed(AdminLogin.routeName);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: white, boxShadow: [
                        BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                      ]),
                      height: 80,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'تسجيل خروج',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
