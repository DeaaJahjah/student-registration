import 'package:dropdown_search/dropdown_search.dart';
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

class MakePaymentScreen extends StatefulWidget {
  static const routeName = '/make-payment-screen';

  const MakePaymentScreen({super.key});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
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
      final order = ModalRoute.of(context)!.settings.arguments as RegistrationOrder;
      total = (order.annulFees ?? 0) + order.registrationFees;
      totalController = TextEditingController(text: ' الاجمالي $total');
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = ModalRoute.of(context)!.settings.arguments as RegistrationOrder;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                CustomAppBar(
                  iconName: 'back',
                  title: 'دفع الرسوم',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                sizedBoxMedium,
                Row(
                  children: [
                    Text('معلومات البطاقة البنكية',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor)),
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
                if (order.acceptencType == 'موازي')
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
                      selectedItem: numberOfPayment,
                      items: const ['دفعتين', 'دفعة'],
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
                        numberOfPayment = value!;
                        if (numberOfPayment == 'دفعة') {
                          total = (order.annulFees ?? 0) + order.registrationFees;
                        } else {
                          total = (order.annulFees! / 2) + order.registrationFees;
                        }
                        totalController = TextEditingController(text: 'الاجمالي $total');
                        setState(() {});
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        // prefixText: numberOfPayment,
                        hintStyle: Theme.of(context).textTheme.headlineSmall,
                      )),
                      dropdownButtonProps: const DropdownButtonProps(
                        padding: EdgeInsets.all(10),
                      ),
                    ),
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
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: secondaryColor)),
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
                Text('ccv2   هو رقم التحقق من صحة البطاقة وتجده على الوجه الخلفي للبطاقة فوق الشريط الأبيض',
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
                          final index = order.payments.indexWhere((element) => element.paymentNumber == 'الأولى');

                          var payment = order.payments.firstWhere((element) => element.paymentNumber == 'الأولى');
                          payment = payment.copyWith(
                            amount: total,
                            dateTime: DateTime.now(),
                          );
                          order.payments.removeAt(index);
                          order.payments.insert(index, payment);
                          order = order.copyWith(
                              numberOfPayments: numberOfPayment == 'دفعة' ? 1 : 2,
                              isCompleted: order.acceptencType == 'عام'
                                  ? true
                                  : numberOfPayment == 'دفعة'
                                      ? true
                                      : false);
                          setState(() {
                            isLoading = true;
                          });

                          await PaymentDbService().makePayment(context, order);

                          setState(() {
                            isLoading = true;
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                        })
                    : const CustomProgress(),
              ],
            ),
          ),
        ))),
      ),
    );
  }
}
