import 'package:flutter/material.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/config/widgets/button_with_shadow.dart';
import 'package:student_registeration_system/config/widgets/custom_appbar.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';
import 'package:student_registeration_system/features/home/screens/home_screen.dart';
import 'package:student_registeration_system/features/payments/models/registration_order.dart';
import 'package:student_registeration_system/features/payments/services/payment_db_services.dart';

class CompletFeesScreen extends StatefulWidget {
  static const routeName = '/complete-payment-screen';

  const CompletFeesScreen({super.key});

  @override
  State<CompletFeesScreen> createState() => _CompletFeesScreenState();
}

class _CompletFeesScreenState extends State<CompletFeesScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  var totalController = TextEditingController();
  final expireYearController = TextEditingController();
  final expireMonthController = TextEditingController();
  final ccv2Controller = TextEditingController();
  String numberOfPayment = 'دفعة';
  bool isLoading = false;
  final _key = GlobalKey<FormState>();

  double total = 0.0;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
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
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    RegistrationOrder order = snapshot.data!.first;

                    double total = order.annulFees! / 2;
                    totalController = TextEditingController(text: ' الاجمالي $total');

                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            CustomAppBar(
                              iconName: 'back',
                              title: 'استكمال رسوم',
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            sizedBoxMedium,
                            if (order.numberOfPayments == 2) ...[
                              Row(
                                children: [
                                  Text('معلومات البطاقة البنكية',
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor)),
                                ],
                              ),
                              TextInput(
                                labelText: 'الاسم على البطاقة',
                                controller: nameController,
                                isRequired: true,
                              ),
                              sizedBoxSmall,
                              TextInput(
                                labelText: 'رقم البطاقة',
                                controller: numberController,
                                isRequired: true,
                                keyboardType: TextInputType.number,
                              ),
                              sizedBoxSmall,
                              TextInput(
                                labelText: 'الاجمالي',
                                controller: totalController,
                                isRequired: true,
                                readOnly: true,
                              ),
                              sizedBoxMedium,
                              Row(
                                children: [
                                  Text('تاريخ انتهاء البطاقة',
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: TextInput(
                                      labelText: 'السنة',
                                      controller: expireYearController,
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextInput(
                                      labelText: 'الشهر',
                                      controller: expireMonthController,
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxSmall,
                              TextInput(
                                labelText: 'ccv2',
                                controller: ccv2Controller,
                                isRequired: true,
                                keyboardType: TextInputType.number,
                              ),
                              sizedBoxSmall,
                              Text(
                                  'ccv2   هو رقم التحقق من صحة البطاقة وتجده على الوجه الخلفي للبطاقة فوق الشريط الأبيض',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor)),
                              sizedBoxLarge,
                              !isLoading
                                  ? ButtonWithShadow(
                                      text: 'دفع',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        if (!_key.currentState!.validate()) {
                                          return;
                                        }
                                        _key.currentState!.save();
                                        final index =
                                            order.payments.indexWhere((element) => element.paymentNumber == 'الثانية');

                                        var payment =
                                            order.payments.firstWhere((element) => element.paymentNumber == 'الثانية');
                                        payment = payment.copyWith(
                                          amount: total,
                                          dateTime: DateTime.now(),
                                        );
                                        order.payments.removeAt(index);
                                        order.payments.insert(index, payment);
                                        order = order.copyWith(isCompleted: true);
                                        setState(() {
                                          isLoading = true;
                                        });

                                        await PaymentDbService().makePayment(context, order);

                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                                      })
                                  : const CustomProgress(),
                            ] else ...[
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Text('تم تسديد الدفعة',
                                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                              )
                            ]
                          ],
                        ),
                      ),
                    ));
                  }

                  return ListView(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAppBar(
                        iconName: 'back',
                        title: 'استكمال رسوم',
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      sizedBoxMedium,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Text('تم تسديد الدفعة',
                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                      )
                    ],
                  );
                })),
      ),
    );
  }
}
