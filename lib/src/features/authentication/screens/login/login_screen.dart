import 'package:flutter/material.dart';

import 'package:tfg_v3/src/common_widgets/authentication/form_header_widget.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:tfg_v3/src/features/authentication/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 24),
          child: Column(
            children: [
              const FormHeaderWidget(
                title: tLoginTitle,
                subTitle: tLoginSubtitle,
              ),
              LoginForm(),
              const LoginFooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
