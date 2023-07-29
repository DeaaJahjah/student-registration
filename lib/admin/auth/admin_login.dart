import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/auth/services/admin_auth_services.dart';
import 'package:student_registeration_system/config/constants/constant.dart';
import 'package:student_registeration_system/config/widgets/custom_progress.dart';
import 'package:student_registeration_system/config/widgets/custom_snackbar.dart';
import 'package:student_registeration_system/config/widgets/shadow_button.dart';
import 'package:student_registeration_system/config/widgets/text_input.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/admin-login';
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          // color: Colors.amber,
          child: Image.asset(
            'assets/images/login_bg.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            left: 300,
            top: MediaQuery.of(context).size.height * 0.3,
            child: SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextInput(labelText: 'البريد الإلكتروني', controller: emailController),
                    sizedBoxMedium,
                    TextInput(labelText: 'كلمة المرور', controller: passwordController),
                    sizedBoxLarge,
                    !isLoading
                        ? ShadowButton(
                            title: 'تسجيل دخول',
                            onTap: () async {
                              if (!_formKey.currentState!.validate()) {
                                showErrorSnackBar(context, 'الرجاء ادخال كل الحقول');
                                return;
                              }

                              if (!emailController.text.contains('@')) {
                                showErrorSnackBar(context, 'البريد المدخل غير صحيح');
                                return;
                              }

                              setState(() {
                                isLoading = true;
                              });

                              await AdminAuthDbServics().signIn(
                                  email: emailController.text, password: passwordController.text, context: context);

                              setState(() {
                                isLoading = false;
                              });
                            },
                          )
                        : const CustomProgress()
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
