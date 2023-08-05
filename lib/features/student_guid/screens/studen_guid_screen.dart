import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';
import 'package:student_registeration_system/features/student_guid/screens/studen_guid_details_screen.dart';
import 'package:student_registeration_system/features/student_guid/services/student_guid_db_services.dart';

class StudentGuidScreen extends StatelessWidget {
  static const routeName = '/student-guid';

  const StudentGuidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          CustomAppBar(
            iconName: 'back',
            title: 'دليل الطالب',
            onTap: () => Navigator.of(context).pop(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '''
          اطلع على الأوراق المطلوبة وكيفية الحصول
           على طلبك من الكلية 
          ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: secondaryColor, fontWeight: FontWeight.w800),
            ),
          ),
          FutureBuilder(
            future: StudentGuidDbServices().getStudentGuid(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(snapshot.error.toString(),
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List<StudentGuid> guids = snapshot.data!;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(StudentGuidDetailsScreen.routeName, arguments: guids[index]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: white, boxShadow: [
                        BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                      ]),
                      height: 80,
                      child: Stack(children: [
                        Align(
                          alignment: index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            height: 80,
                            width: 10,
                            color: secondaryColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            guids[index].title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      ]),
                    ),
                  );
                },
              );
            },
          )
        ],
      )),
    );
  }
}
