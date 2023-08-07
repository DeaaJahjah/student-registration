import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';
import 'package:student_registeration_system/features/student_guid/services/student_guid_db_services.dart';

Future<void> showEditGuidDialog(context, StudentGuid guid) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('تعديل الدليل'),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close))
          ],
        ),

        content: EditStudentGuidBody(guid: guid),
       
      );
    },
  );
}

class EditStudentGuidBody extends StatefulWidget {
  const EditStudentGuidBody({required this.guid, super.key});
  final StudentGuid guid;

  @override
  State<EditStudentGuidBody> createState() => _EditStudentGuidBodyState();
}

class _EditStudentGuidBodyState extends State<EditStudentGuidBody> {
  var docsContrller = TextEditingController();
  var pathContrller = TextEditingController();
  var costContrller = TextEditingController();
  var linkContrller = TextEditingController();
  var titleContrller = TextEditingController();

  @override
  void initState() {
    docsContrller = TextEditingController(text: widget.guid.requiredDocs);
    pathContrller = TextEditingController(text: widget.guid.path);
    costContrller = TextEditingController(text: widget.guid.fees.toString());
    linkContrller = TextEditingController(text: widget.guid.link);

    titleContrller = TextEditingController(text: widget.guid.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
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
            sizedBoxMedium,
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
              const SizedBox(width: 10),
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
            sizedBoxMedium,
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
              const SizedBox(width: 10),
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

                    await StudentGuidDbServices().updateGuid(
                        context,
                        StudentGuid(
                            id: widget.guid.id,
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
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
