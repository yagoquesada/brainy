import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/common_widgets/authentication/form_header_widget.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/authentication/screens/signup/signup_footer_widget.dart';
import 'package:tfg_v3/src/features/authentication/screens/signup/signup_form_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pswdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Column(
            children: [
              const FormHeaderWidget(
                title: tSignUpTitle,
                subTitle: tSignUpSubtitle,
              ),
              SignUpFormWidget(),
              const SignUpFooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
