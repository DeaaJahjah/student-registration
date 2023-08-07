import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:student_registeration_system/config/services/file_db_service.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/features/ads/models/ad.dart';
import 'package:student_registeration_system/features/ads/services/ads_db_services.dart';

Future<void> showAlertDialog(context, Ad ad) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: const Text('تعديل الإعلان'),
        content: EditAdBody(ad: ad),
        // actions: <Widget>[

        // ],
      );
    },
  );
}

class EditAdBody extends StatefulWidget {
  const EditAdBody({required this.ad, super.key});
  final Ad ad;

  @override
  State<EditAdBody> createState() => _EditAdBodyState();
}

class _EditAdBodyState extends State<EditAdBody> {
  String? imageName;
  FilePickerResult? pickedFile;
  Uint8List? logoBase64;
  var textContrller = TextEditingController();

  @override
  void initState() {
    textContrller = TextEditingController(text: widget.ad.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(children: <Widget>[
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
            },
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              alignment: Alignment.center,
              child: (pickedFile != null)
                  ? Image.memory(logoBase64!)
                  : widget.ad.image != null
                      ? Image.network(widget.ad.image!)
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
        Row(
          children: [
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('موافق'),
              onPressed: () async {
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
                } else {
                  imageUrl = widget.ad.image;
                }

                await AdsDbServices()
                    .updateAd(context, Ad(id: widget.ad.id, text: textContrller.text, image: imageUrl));

                // await AdsDbServices().updateAd(context, ad);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ]),
    );
  }
}
