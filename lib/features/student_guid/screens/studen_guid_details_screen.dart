import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/shadow_button.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';
import 'package:student_registeration_system/features/student_guid/screens/widgets/underline_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StudentGuidDetailsScreen extends StatelessWidget {
  static const routeName = '/student-guid-details';

  const StudentGuidDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final guid = ModalRoute.of(context)!.settings.arguments as StudentGuid;
    const guid = StudentGuid(
        id: 'dada',
        title: 'مصدقة تخرج',
        fees: 50000,
        link: 'http://www.mohe.gov.sy/mohe/',
        path: 'توقيع اتحاد الطلبة - الشؤون الطلابية - الامتحانات - رئيس الدائرة - العميد أو النائب',
        requiredDocs: 'براءة ذمة موقعة من السكن الجامعي - صورة عن الهوية - طلب من الديوان مع الطوابع');
    final List<String> docs = guid.requiredDocs.split('-').toList();
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          CustomAppBar(
            iconName: 'back',
            title: guid.title,
            onTap: () => Navigator.of(context).pop(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''
للحصول على ${guid.title} يجب تقديم الأوراق
المطلوبة إلى المسار المحدد
          ''',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: secondaryColor, fontWeight: FontWeight.w800),
                ),
                const UnderLineText(title: 'الأوراق المطلوبة'),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: secondaryColor,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Text(
                            docs[index],
                            style: Theme.of(context).textTheme.headlineMedium,
                          )
                        ],
                      ),
                    );
                  },
                ),
                const UnderLineText(title: 'المسار'),
                const UnderLineText(title: 'الرسوم'),
                sizedBoxSmall,
                Text(
                  '${guid.fees} ل.س فقط',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: secondaryColor),
                ),
                if (guid.link != null)
                  ShadowButton(
                    title: 'فتح الرابط',
                    onTap: () async {
                      if (await canLaunchUrlString(guid.link!)) {
                        await launchUrlString(guid.link!);
                      } else {}
                    },
                  )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
