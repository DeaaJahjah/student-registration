import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/registration_appBare.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/registration/models/collage.dart';
import 'package:student_registeration_system/features/registration/screens/partisan_info.dart';
import 'package:student_registeration_system/features/registration/services/collage_db_services.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../providers/registration_provider.dart';

class CollegeInfo extends StatefulWidget {
  static const routeName = '/college_info';
  const CollegeInfo({Key? key}) : super(key: key);

  @override
  State<CollegeInfo> createState() => _CollegeInfoState();
}

class _CollegeInfoState extends State<CollegeInfo> {
  final collegeNameController = TextEditingController();
  final sectionController = TextEditingController();
  final languageController = TextEditingController();
  final _key = GlobalKey<FormState>();
  int? _groupValue = 0;
  Collage? selectedCollage;
  String? acceptanceType;
  @override
  Widget build(BuildContext context) {
    CollageDbService().getCollages();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                RegistrationAppBare(title: 'معلومات الكلية'),
                sizedBoxSmall,

                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      color: white,
                      boxShadow: const [BoxShadow(offset: Offset(-3, 2), blurRadius: 4, color: primaryColor)]),
                  child: DropdownSearch<Collage>(
                    validator: (value) {
                      if (value == null) return 'الحقل مطلوب';

                      return null;
                    },
                    asyncItems: (e) => CollageDbService().getCollages(),
                    itemAsString: (collage) => collage.name,
                    selectedItem: selectedCollage,
                    dropdownBuilder: (context, selectedItem) {
                      if (selectedItem != null) {
                        return Text(
                          selectedItem.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    onChanged: (value) {
                      selectedCollage = value;
                      setState(() {});
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      prefixText: selectedCollage == null ? 'اختر الكلية' : null,
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                    )),
                    dropdownButtonProps: const DropdownButtonProps(
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ),

                sizedBoxSmall,

                if (selectedCollage != null && selectedCollage!.departments!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        color: white,
                        boxShadow: const [BoxShadow(offset: Offset(-3, 2), blurRadius: 4, color: primaryColor)]),
                    child: DropdownSearch<String>(
                      validator: (value) {
                        if (value == null) return 'الحقل مطلوب';

                        return null;
                      },
                      itemAsString: (section) => section,
                      selectedItem: sectionController.text,
                      items: selectedCollage!.departments!,
                      dropdownBuilder: (context, selectedItem) {
                        if (selectedItem != null) {
                          return Text(
                            selectedItem,
                            style: Theme.of(context).textTheme.headlineSmall,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      onChanged: (value) {
                        sectionController.text = value!;
                        setState(() {});
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        prefixText: sectionController.text.isEmpty ? 'اختر القسم' : null,
                        hintStyle: Theme.of(context).textTheme.headlineSmall,
                      )),
                      dropdownButtonProps: const DropdownButtonProps(
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),

                sizedBoxSmall,
//Selecte acceptence type
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      color: white,
                      boxShadow: const [BoxShadow(offset: Offset(-3, 2), blurRadius: 4, color: primaryColor)]),
                  child: DropdownSearch<String>(
                    validator: (value) {
                      if (value == null) return 'الحقل مطلوب';

                      return null;
                    },
                    itemAsString: (type) => type,
                    selectedItem: acceptanceType,
                    items: const ['عام', 'موازي'],
                    dropdownBuilder: (context, selectedItem) {
                      if (selectedItem != null) {
                        return Text(
                          selectedItem,
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    onChanged: (value) {
                      acceptanceType = value!;
                      setState(() {});
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      prefixText: acceptanceType == null ? 'نوع القبول' : null,
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                    )),
                    dropdownButtonProps: const DropdownButtonProps(
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ),

                sizedBoxSmall,
                TextInput(
                  controller: languageController,
                  labelText: 'لغة التفاضل',
                ),
                sizedBoxLarge,
                Center(
                  child: Text(
                    'هل أنت متفرغ للدراسة',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                // sizedBoxSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('لا', style: Theme.of(context).textTheme.displayLarge),
                    Radio(
                        hoverColor: secondaryColor,
                        value: 1,
                        activeColor: secondaryColor,
                        groupValue: _groupValue,
                        onChanged: (newValue) {
                          setState(() {
                            _groupValue = newValue;
                          });
                        }),
                    Text('نعم', style: Theme.of(context).textTheme.displayLarge),
                    Radio(
                        value: 0,
                        activeColor: secondaryColor,
                        groupValue: _groupValue,
                        onChanged: (newValue) {
                          setState(() {
                            _groupValue = newValue;
                          });
                        }),
                  ],
                ),
                sizedBoxLarge,
                Center(
                    child: ButtonWithShadow(
                  text: 'التالي',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (!_key.currentState!.validate()) {
                      return;
                    }
                    _key.currentState!.save();

                    context.read<RegistrationProvider>().student = context
                        .read<RegistrationProvider>()
                        .student
                        .copyWith(
                          collageName: selectedCollage!.name,
                          collageId: selectedCollage!.id,
                          departmentName: sectionController.text,
                          secondLanguage: languageController.text,
                          annualFees: acceptanceType != 'عام' ? selectedCollage!.annualFees : null,
                          acceptanceType: acceptanceType == 'عام' ? AcceptanceType.general : AcceptanceType.parallel,
                          freeToStudy: _groupValue == 1 ? true : false,
                        );

                    Navigator.of(context).pushNamed(PartisanInfo.routeName);
                  },
                )),
                sizedBoxSmall,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
