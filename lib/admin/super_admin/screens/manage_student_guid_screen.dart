import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/admin/super_admin/screens/edit_guid_screens.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';
import 'package:student_registeration_system/features/student_guid/screens/widgets/underline_text.dart';
import 'package:student_registeration_system/features/student_guid/services/student_guid_db_services.dart';

class ManageStudentGuidScreen extends StatefulWidget {
  static const routeName = '/manage-student-guid';

  const ManageStudentGuidScreen({super.key});

  @override
  State<ManageStudentGuidScreen> createState() => _ManageStudentGuidScreenState();
}

class _ManageStudentGuidScreenState extends State<ManageStudentGuidScreen> {
  final docsContrller = TextEditingController();
  final pathContrller = TextEditingController();
  final costContrller = TextEditingController();
  final linkContrller = TextEditingController();

  final titleContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(indicatorColor: secondaryColor, padding: const EdgeInsets.all(10), tabs: [
              Text('دليل الطالب', style: Theme.of(context).textTheme.headlineMedium),
              Text('إضافة دليل الطالب', style: Theme.of(context).textTheme.headlineMedium),
            ]),
          ),
          body: TabBarView(children: [
            FutureBuilder<List<StudentGuid>>(
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
                  if (snapshot.hasData) {
                    final List<StudentGuid> studentGuids = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(50),
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: studentGuids.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              childAspectRatio: 4 / 2,
                              maxCrossAxisExtent: 900,
                              mainAxisExtent: 650,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            final guid = studentGuids[index];
                            final List<String> docs = guid.requiredDocs.split(',').toList();
                            final List<String> path = guid.path.split(',').toList();
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 25, top: 50),
                                  // padding: const EdgeInsets.only(bottom: 50),
                                  // height: 800,
                                  decoration: const BoxDecoration(color: white, boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                                  ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              QuickAlert.show(
                                                  context: context,
                                                  customAsset: 'assets/images/confirm.gif',
                                                  type: QuickAlertType.confirm,
                                                  text: 'هل انت متأكد من حذف هذا الدليل؟',
                                                  confirmBtnText: 'نعم',
                                                  cancelBtnText: 'لا',
                                                  confirmBtnColor: primaryColor,
                                                  onConfirmBtnTap: () async {
                                                    Navigator.pop(context);
                                                    bool result = await StudentGuidDbServices()
                                                        .deleteGuid(context, studentGuids[index].id);
                                                    if (result) {
                                                      setState(() {});
                                                    }
                                                  });
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: const BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      sizedBoxLarge,
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
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: path.length,
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
                                                  path[index],
                                                  style: Theme.of(context).textTheme.headlineMedium,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      const UnderLineText(title: 'الرسوم'),
                                      sizedBoxSmall,
                                      Text(
                                        '${guid.fees} ل.س فقط',
                                        style:
                                            Theme.of(context).textTheme.headlineMedium!.copyWith(color: secondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                    bottom: 0,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: () async {
                                          await showEditGuidDialog(context, guid);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          margin: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                              color: white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(-2, 2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    color: Colors.black54)
                                              ]),
                                          child: const Icon(
                                            Icons.edit,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            );
                          }),
                    );
                  }
                  return const SizedBox.shrink();
                }),

            //! Add Guid
            Padding(
              padding: const EdgeInsets.all(50),
              child: ListView(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text('عنوان الدليل', style: Theme.of(context).textTheme.headlineMedium),
                          TextFormField(
                            controller: titleContrller,
                            minLines: 5,
                            maxLines: 200,
                            decoration: InputDecoration(
                                hintText: 'عنوان الدليل',
                                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context).textTheme.headlineMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text('الأوراق المطلوية', style: Theme.of(context).textTheme.headlineMedium),
                          TextFormField(
                            controller: docsContrller,
                            minLines: 5,
                            maxLines: 50,
                            decoration: InputDecoration(
                                hintText: 'أدخل الأوراق المطلوبة',
                                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context).textTheme.headlineMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text('مسار المعاملة', style: Theme.of(context).textTheme.headlineMedium),
                          TextFormField(
                            controller: pathContrller,
                            minLines: 5,
                            maxLines: 200,
                            decoration: InputDecoration(
                                hintText: 'أدخل مسار المعاملة',
                                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context).textTheme.headlineMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text('الرسوم', style: Theme.of(context).textTheme.headlineMedium),
                          TextFormField(
                            controller: costContrller,
                            minLines: 5,
                            maxLines: 200,
                            decoration: InputDecoration(
                                hintText: 'أدخل رسوم المعاملة',
                                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context).textTheme.headlineMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Text('رابط التفاصيل', style: Theme.of(context).textTheme.headlineMedium),
                          TextFormField(
                            controller: linkContrller,
                            minLines: 5,
                            maxLines: 200,
                            decoration: InputDecoration(
                                hintText: 'ادخل الرابط',
                                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context).textTheme.headlineMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                    child: ButtonWithShadow(
                        text: 'حفظ',
                        onTap: () async {
                          if (docsContrller.text.isEmpty &&
                              costContrller.text.isEmpty &&
                              pathContrller.text.isEmpty &&
                              titleContrller.text.isEmpty) {
                            showErrorSnackBar(context, 'الرجاء ادخال البيانات');
                            return;
                          }

                          await StudentGuidDbServices().addGuid(
                              context,
                              StudentGuid(
                                  id: '',
                                  title: titleContrller.text,
                                  path: pathContrller.text,
                                  requiredDocs: docsContrller.text,
                                  fees: double.tryParse(costContrller.text)!,
                                  link: linkContrller.text));

                          setState(() {
                            docsContrller.clear();
                            pathContrller.clear();
                            costContrller.clear();
                            linkContrller.clear();
                          });
                        }),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
