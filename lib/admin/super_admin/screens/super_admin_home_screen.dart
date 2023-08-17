import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:student_registeration_system/admin/admin_home/widgets/side_button.dart';
import 'package:student_registeration_system/admin/auth/admin_login.dart';
import 'package:student_registeration_system/admin/super_admin/screens/manage_registration_fees_screen.dart';
import 'package:student_registeration_system/admin/super_admin/screens/manage_student_guid_screen.dart';
import 'package:student_registeration_system/admin/super_admin/services/super_admin_db_services.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';

class SuperAdminHomeScreen extends StatefulWidget {
  static const routeName = '/super-admin-home-screen';

  const SuperAdminHomeScreen({super.key});

  @override
  State<SuperAdminHomeScreen> createState() => _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends State<SuperAdminHomeScreen> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        if (selectedPageIndex == 0) const ManageStudentGuidScreen(),
        if (selectedPageIndex == 1) const ManageRegistrationFeesScreen(),
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
                  title: 'دليل الطالب',
                  index: 0,
                  isSelected: selectedPageIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedPageIndex = 0;
                    });
                  },
                ),
                SideButton(
                  title: 'رسوم وأقساط',
                  index: 1,
                  isSelected: selectedPageIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedPageIndex = 1;
                    });
                  },
                ),
                StreamBuilder(
                    stream: SuperAdminDbService().getRegsterationState(context),
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
                            const Text('فتح التسجيل للطلاب الجدد'),
                            Switch(
                                value: snapshot.data!.data()!['active_registration_for_new_students'],
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
                                        await SuperAdminDbService().updateRegistrationState(context, value);
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
