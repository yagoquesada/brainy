import 'package:flutter/material.dart';

import 'package:tfg_v3/src/common_widgets/authentication/form_header_widget.dart';
import 'package:tfg_v3/src/features/authentication/login/login_footer_widget.dart';
import 'package:tfg_v3/src/features/authentication/login/login_form.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';

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
    return Scaffold(
      body: getBody(),
    );
  }

  SingleChildScrollView getBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: YHelperFunctions.screenHeight(),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const FormHeaderWidget(
              title: YTexts.tLoginTitle,
              subTitle: YTexts.tLoginSubtitle,
            ),
            const Spacer(),
            LoginForm(),
            const Spacer(),
            const LoginFooterWidget(),
            const Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}
