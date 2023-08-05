import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/shadow_button.dart';
import 'package:student_registeration_system/features/ads/models/ad.dart';
import 'package:student_registeration_system/features/ads/services/ads_db_services.dart';

class AdsScreen extends StatelessWidget {
  static const routeName = '/ads-screen';
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          CustomAppBar(
            iconName: 'back',
            title: 'اعلانات',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const Padding(
            padding: EdgeInsets.all(35.0),
            child: ShadowButton(title: 'برنامج دوام الكلية التطبيقية'),
          ),
          const AdsBody()
        ],
      )),
    );
  }
}

class AdsBody extends StatelessWidget {
  const AdsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AdsDbServices().getAds(context),
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
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            List<Ad> ads = snapshot.data!;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: white,
                  boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      color: secondaryColor,
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
                        width: 100,
                        height: 100,
                      )
                  ]),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
