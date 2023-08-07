import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/features/home/models/category.dart';
import 'package:student_registeration_system/features/registration/services/student_db_services.dart';

class HomeBody extends StatelessWidget {
  HomeBody({
    super.key,
    required this.loadingCollageId,
  });
  bool loadingCollageId;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        if (categories[index].routeName == '/register-for-new-year') {
          if (!loadingCollageId) {
            FutureBuilder(
                future: StudentsDbService().checkRegisterIsActive(context),
                builder: (context, snapshot) {
                  (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(snapshot.error.toString(),
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
                    }
                    return CategoreCard(
                      index: index,
                    );
                  };
                  return const SizedBox.shrink();
                });
          }
        }
        return CategoreCard(
          index: index,
        );
      },
    );
  }
}

class CategoreCard extends StatelessWidget {
  const CategoreCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(categories[index].routeName);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: white,
            boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
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
              categories[index].title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        ]),
      ),
    );
  }
}
