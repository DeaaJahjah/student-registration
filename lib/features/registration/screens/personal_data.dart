import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/services/file_db_service.dart';
import 'package:student_registeration_system/config/services/files_picker.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'package:path/path.dart' as path;
import 'package:student_registeration_system/features/registration/providers/registration_provider.dart';
import 'package:student_registeration_system/features/registration/screens/complete_data.dart';

class PersonalData extends StatefulWidget {
  static const routeName = '/personal_date';
  const PersonalData({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final fullNameController = TextEditingController();
  final nationalityController = TextEditingController();
  final workController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  bool isLoading = false;
  String? imageName;
  File? imageFile;

  final _key = GlobalKey<FormState>();
  DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                RegistrationAppBare(
                  title: 'أدخل بياناتك الشخصية',
                ),
                Text(
                  'الصورة الشخصية',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      imageFile = await FilesPicker().pickImage();
                      imageName = path.basename(imageFile!.path);
                      setState(() {});
                    } catch (e) {}
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(border: Border.all(color: primaryColor)),
                    child: (imageFile == null)
                        ? Image.asset(
                            'assets/images/user.png',
                          )
                        : Image.file(imageFile!),
                  ),
                ),
                sizedBoxSmall,
                TextInput(
                  controller: fullNameController,
                  labelText: 'الاسم الكامل',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: nationalityController,
                  labelText: 'الجنسية',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: workController,
                  labelText: 'العمل',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: placeOfBirthController,
                  labelText: 'مكان الولادة',
                ),
                sizedBoxSmall,
                TextInput(
                  controller: dateOfBirthController,
                  labelText: 'تاريخ الولادة',
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    birthday = await showRoundedDatePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      initialDate: DateTime(1990),
                      // firstDate: DateTime(2000),
                      theme: ThemeData(primarySwatch: Colors.indigo),
                    );
                    dateOfBirthController.text = ('${birthday!.year}-${birthday!.month}-${birthday!.day}').toString();
                  },
                ),
                sizedBoxMedium,
                Center(
                    child: isLoading
                        ? const Center(child: CustomProgress())
                        : ButtonWithShadow(
                            text: 'التالي',
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              if (!_key.currentState!.validate()) {
                                return;
                              }
                              _key.currentState!.save();
                              String? imageUrl;

                              setState(() {
                                isLoading = true;
                              });
                              if (imageFile != null) {
                                imageUrl = await FileDbService(context).uploadeimage(imageName!, imageFile!);
                              }

                              if (imageUrl == 'error') {
                                showErrorSnackBar(context, 'حدث خطأ, الراجاء المحاولة مرة أخرى');
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
                              if (mounted) {
                                context.read<RegistrationProvider>().student =
                                    context.read<RegistrationProvider>().student.copyWith(
                                          fullName: fullNameController.text,
                                          nationality: nationalityController.text,
                                          work: workController.text,
                                          placeOfBirth: placeOfBirthController.text,
                                          birthday: birthday,
                                          image: imageUrl,
                                        );

                                Navigator.of(context).pushNamed(CompleteData.routeName);
                              }
                            }))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
