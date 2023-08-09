import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/skip_button.dart';
import 'package:student_registeration_system/features/payments/models/registration_order.dart';
import 'package:student_registeration_system/features/payments/screens/make_payment_screen.dart';
import 'package:student_registeration_system/features/payments/services/payment_db_services.dart';

class CongratsScreen extends StatelessWidget {
  static const routeName = '/congrats-screen';

  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<RegistrationOrder>>(
            future: PaymentDbService().getLastPayment(),
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
                RegistrationOrder? order = snapshot.data!.isNotEmpty ? snapshot.data!.first : null;
                double total = 0.0;
                if (order != null) {
                  total = (order.annulFees ?? 0) + (order.registrationFees);
                }
                return SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppBar(
                      iconName: 'back',
                      title: 'تسجيل',
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    sizedBoxSmall,
                    if (order != null && order.numberOfPayments != 2) ...[
                      Image.asset('assets/images/congrats.png'),
                      Text('مبروك الترفع إلى السنة ${order.year}', style: Theme.of(context).textTheme.headlineMedium),
                      Text('رسوم السنة ${order.year}\n $total ل.س',
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                      sizedBoxLarge,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: ButtonWithShadow(
                            text: 'تسديد الرسوم',
                            onTap: () {
                              Navigator.of(context).pushNamed(MakePaymentScreen.routeName, arguments: order);
                            }),
                      ),
                      sizedBoxSmall,
                      SkipButton(
                          title: 'لاحقا',
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ] else ...[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Text('لا يوجد دفعات لتسديدها',
                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                      )
                    ]
                  ],
                ));
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
