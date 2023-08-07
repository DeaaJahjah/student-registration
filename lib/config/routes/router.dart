import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/admin_home/screens/admin_home_screen.dart';
import 'package:student_registeration_system/admin/admin_home/screens/manage_ads_screen.dart';
import 'package:student_registeration_system/admin/auth/admin_login.dart';
import 'package:student_registeration_system/admin/super_admin/screens/manage_student_guid_screen.dart';
import 'package:student_registeration_system/admin/super_admin/screens/super_admin_home_screen.dart';
import 'package:student_registeration_system/features/notification/notification_screen.dart';
import 'package:student_registeration_system/features/registration/screens/addtional_info.dart';
import 'package:student_registeration_system/features/registration/screens/bro_sis_info_screen.dart';
import 'package:student_registeration_system/features/registration/screens/college_info.dart';
import 'package:student_registeration_system/features/registration/screens/complete_data.dart';
import 'package:student_registeration_system/features/registration/screens/contact_information.dart';
import 'package:student_registeration_system/features/registration/screens/father_info.dart';
import 'package:student_registeration_system/features/registration/screens/high_school_sertificat.dart';
import 'package:student_registeration_system/features/registration/screens/mother_info.dart';
import 'package:student_registeration_system/features/registration/screens/partisan_info.dart';
import 'package:student_registeration_system/features/registration/screens/personal_data.dart';
import 'package:student_registeration_system/features/registration/screens/schools_info.dart';
import 'package:student_registeration_system/features/registration/screens/verfiy_phone_number_screen.dart';
import 'package:student_registeration_system/features/ads/screens/ads_screen.dart';
import 'package:student_registeration_system/features/home/screens/home_screen.dart';
import 'package:student_registeration_system/features/student_guid/screens/studen_guid_screen.dart';
import 'package:student_registeration_system/features/student_guid/screens/studen_guid_details_screen.dart';
import 'package:student_registeration_system/splash_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case PersonalData.routeName:
      return MaterialPageRoute(builder: (_) => const PersonalData());
    case CompleteData.routeName:
      return MaterialPageRoute(builder: (_) => const CompleteData());
    case ContactInformation.routeName:
      return MaterialPageRoute(builder: (_) => const ContactInformation());
    case FatherInfo.routeName:
      return MaterialPageRoute(builder: (_) => const FatherInfo());
    case MotherInfo.routeName:
      return MaterialPageRoute(builder: (_) => const MotherInfo());
    case BroAndSisInfo.routeName:
      return MaterialPageRoute(builder: (_) => const BroAndSisInfo());
    case SchoolsInfo.routeName:
      return MaterialPageRoute(builder: (_) => const SchoolsInfo());
    case HighSchoolSertificat.routeName:
      return MaterialPageRoute(builder: (_) => const HighSchoolSertificat());
    case CollegeInfo.routeName:
      return MaterialPageRoute(builder: (_) => const CollegeInfo());
    case PartisanInfo.routeName:
      return MaterialPageRoute(builder: (_) => const PartisanInfo());
    case AddtionalInfo.routeName:
      return MaterialPageRoute(builder: (_) => const AddtionalInfo());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case AdsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdsScreen());
    case StudentGuidScreen.routeName:
      return MaterialPageRoute(builder: (_) => const StudentGuidScreen());
    case VerfiyPhoneNumberScree.routeName:
      return MaterialPageRoute(builder: (_) => const VerfiyPhoneNumberScree());
    case StudentGuidDetailsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const StudentGuidDetailsScreen(), settings: settings);
    case NotificationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationScreen(), settings: settings);

    //!Admin routes
    case AdminLogin.routeName:
      return MaterialPageRoute(builder: (_) => const AdminLogin());
    case AdminHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminHomeScreen());

    case SuperAdminHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SuperAdminHomeScreen());
    case ManageAdsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ManageAdsScreen());
    case ManageStudentGuidScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ManageStudentGuidScreen());
  }

  return null;
}
