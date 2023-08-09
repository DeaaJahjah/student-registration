import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/features/payments/models/registration_order.dart';
import 'package:student_registeration_system/features/payments/services/payment_db_services.dart';

class PaymentsScreen extends StatelessWidget {
  static const routeName = '/payments-screen';

  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(
            iconName: 'back',
            title: 'المدفوعات',
            onTap: () => Navigator.of(context).pop(),
          ),
          FutureBuilder<List<RegistrationOrder>>(
              future: PaymentDbService().getAllPayments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomProgress();
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(snapshot.error.toString(),
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
                }
                if (snapshot.hasData) {
                  final payments = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final payment = payments[index];
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: white, boxShadow: [
                          BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)
                        ]),
                        height: 170,
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 170,
                              width: 10,
                              color: secondaryColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'رسوم السنة ${payment.year}  ${payment.numberOfPayments == 1 ? '' : payment.id}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: secondaryColor, fontWeight: FontWeight.bold),
                                  ),
                                  sizedBoxSmall,
                                  Text(
                                    'تم تسديد مبلغ ${payment.registrationFees} في تاريخ ${payment.createdAt.year}-${payment.createdAt.month}-${payment.createdAt.day}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  sizedBoxSmall,
                                  Row(
                                    children: [
                                      Text(
                                        'وضع الطالب',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(.2),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                          payment.studyState,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              }),
        ],
      ),
    );
  }
}
