import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/admin/admin_home/screens/edit_ad_screens.dart';
import 'package:student_registeration_system/config/services/file_db_service.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/ads/models/ad.dart';
import 'package:student_registeration_system/features/ads/services/ads_db_services.dart';
import 'package:file_picker/file_picker.dart';

class ManageAdsScreen extends StatefulWidget {
  static const routeName = '/manage-ads';

  const ManageAdsScreen({super.key});

  @override
  State<ManageAdsScreen> createState() => _ManageAdsScreenState();
}

class _ManageAdsScreenState extends State<ManageAdsScreen> {
  final textContrller = TextEditingController();
  String? imageName;
  File? imageFile;
  FilePickerResult? pickedFile;
  Uint8List? logoBase64;
  void chooseImage() async {
    pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      try {
        setState(() {
          logoBase64 = pickedFile!.files.first.bytes;
          imageName = pickedFile!.files.first.name;
        });
      } catch (err) {
        print(err);
      }
    } else {
      print('No Image Selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(indicatorColor: secondaryColor, padding: const EdgeInsets.all(10), tabs: [
              Text('اعلانات الكلية', style: Theme.of(context).textTheme.headlineMedium),
              Text('اضافة اعلان', style: Theme.of(context).textTheme.headlineMedium),
            ]),
          ),
          body: TabBarView(children: [
            FutureBuilder<List<Ad>>(
                future: AdsDbServices().getCollageAds(),
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
                    final List<Ad> ads = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(50),
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: ads.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 20, mainAxisExtent: 200),
                          itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25, top: 50),
                                    // padding: const EdgeInsets.only(bottom: 50),
                                    decoration: const BoxDecoration(color: white, boxShadow: [
                                      BoxShadow(
                                          offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                                    ]),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: InkWell(
                                            onTap: () async {
                                              QuickAlert.show(
                                                  context: context,
                                                  customAsset: 'assets/images/confirm.gif',
                                                  type: QuickAlertType.confirm,
                                                  text: 'هل انت متأكد من حذف الإعلان؟',
                                                  confirmBtnText: 'نعم',
                                                  cancelBtnText: 'لا',
                                                  confirmBtnColor: primaryColor,
                                                  onConfirmBtnTap: () async {
                                                    Navigator.pop(context);
                                                    bool result =
                                                        await AdsDbServices().deleteAd(context, ads[index].id);
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
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                                              child: Text(
                                                ads[index].text,
                                                style: Theme.of(context).textTheme.headlineMedium,
                                              ),
                                            ),
                                          ),
                                          if (ads[index].image != null)
                                            Image.network(
                                              ads[index].image!,
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 200,
                                            )
                                          else
                                            const SizedBox(
                                              width: 200,
                                              height: 200,
                                            )
                                        ]),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 225,
                                    bottom: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        await showAlertDialog(context, ads[index]);
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
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
                                  ),
                                ],
                              )),
                    );
                  }
                  return const SizedBox.shrink();
                }),

            //! Add ad
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: textContrller,
                        minLines: 10,
                        maxLines: 200,
                        decoration: InputDecoration(
                            hintText: 'أضف نص',
                            hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                            labelStyle: Theme.of(context).textTheme.headlineMedium,
                            border: const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          try {
                            chooseImage();
                            setState(() {});
                          } catch (e) {}
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          alignment: Alignment.center,
                          child: (pickedFile != null)
                              ? Image.memory(logoBase64!)
                              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(
                                    'اضف صورة',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.grey,
                                  )
                                ]),
                        )),
                  ]),
                  const SizedBox(height: 50),
                  ButtonWithShadow(
                      text: 'حفظ',
                      onTap: () async {
                        if (textContrller.text.isEmpty) {
                          showErrorSnackBar(context, 'الرجاء ادخال نص');
                          return;
                        }
                        QuickAlert.show(
                          context: context,
                          customAsset: 'assets/images/loading.gif',
                          type: QuickAlertType.loading,
                        );
                        String? imageUrl;
                        if (pickedFile != null) {
                          imageUrl = await FileDbService(context).uploadeFile(imageName!, logoBase64!);

                          if (imageUrl == 'error') {
                            QuickAlert.show(
                              context: context,
                              customAsset: 'assets/images/error.gif',
                              type: QuickAlertType.error,
                              text: 'حدث خطأ',
                            );
                            Navigator.pop(context);
                            return;
                          }
                        }

                        await AdsDbServices().addAd(context, Ad(id: '', text: textContrller.text, image: imageUrl));

                        setState(() {
                          textContrller.clear();
                          pickedFile = null;
                        });
                      })
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
