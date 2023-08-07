import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/super_admin/models/fee.dart';
import 'package:student_registeration_system/admin/super_admin/services/registration_fees_db_service.dart';
import 'package:student_registeration_system/admin/super_admin/widgets/collage_fee_card.dart';
import 'package:student_registeration_system/admin/super_admin/widgets/registreation_fee_card.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/utils/transate_enums.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';
import 'package:student_registeration_system/features/student_guid/services/student_guid_db_services.dart';
import 'package:student_registeration_system/registration/models/collage.dart';
import 'package:student_registeration_system/registration/services/collage_db_services.dart';

class ManageRegistrationFeesScreen extends StatefulWidget {
  static const routeName = '/manage-fees';

  const ManageRegistrationFeesScreen({super.key});

  @override
  State<ManageRegistrationFeesScreen> createState() => _ManageRegistrationFeesScreenState();
}

class _ManageRegistrationFeesScreenState extends State<ManageRegistrationFeesScreen> {
  final docsContrller = TextEditingController();
  final pathContrller = TextEditingController();
  final costContrller = TextEditingController();
  final linkContrller = TextEditingController();

  final titleContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // RegistrationFeesDbService().createFee();
    return Expanded(
      flex: 8,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(indicatorColor: secondaryColor, padding: const EdgeInsets.all(10), tabs: [
              Text('رسوم الجامعات', style: Theme.of(context).textTheme.headlineMedium),
              Text('أقساط الجامعات', style: Theme.of(context).textTheme.headlineMedium),
            ]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      child: FutureBuilder<List<Fee>>(
                          future: RegistrationFeesDbService().getRegistrationFees(context, AcceptanceType.parallel),
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
                              final List<Fee> parallelFees = snapshot.data!;

                              return Padding(
                                padding: const EdgeInsets.all(50),
                                child: Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'موازي',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: parallelFees.length,
                                      itemBuilder: (context, index) => RegistrationFeeCard(
                                        fee: parallelFees[index],
                                      ),
                                    )
                                  ],
                                )),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: FutureBuilder<List<Fee>>(
                          future: RegistrationFeesDbService().getRegistrationFees(context, AcceptanceType.general),
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
                              final List<Fee> generallFees = snapshot.data!;

                              return Padding(
                                padding: const EdgeInsets.all(50),
                                child: Container(
                                    // decoration: BoxDecoration(border: Border.all(color: secondaryColor, width: 1)),
                                    child: Column(
                                  children: [
                                    Text(
                                      'عام',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: generallFees.length,
                                      itemBuilder: (context, index) => RegistrationFeeCard(
                                        fee: generallFees[index],
                                      ),
                                    )
                                  ],
                                )),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                    ),
                  ),
                ],
              ),
            ),

            //! Add Guid
            Padding(
                padding: const EdgeInsets.all(50),
                child: FutureBuilder<List<Collage>>(
                    future: CollageDbService().getCollages(),
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
                        final List<Collage> colleges = snapshot.data!;

                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          padding: const EdgeInsets.all(10),
                          itemCount: colleges.length,
                          itemBuilder: (context, index) => CollageFeeCard(collage: colleges[index]),
                        );
                      }
                      return const SizedBox.shrink();
                    }))
          ]),
        ),
      ),
    );
  }
}
