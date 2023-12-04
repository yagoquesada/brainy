import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/app/authentication/widgets/form_header_widget.dart';
import 'package:tfg_v3/src/app/authentication/widgets/signup_footer_widget.dart';
import 'package:tfg_v3/src/app/authentication/widgets/signup_form_widget.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
              title: YTexts.signUpTitle,
              subTitle: YTexts.signUpSubtitle,
            ),
            const Spacer(),
            SignUpFormWidget(),
            const Spacer(),
            const SignUpFooterWidget(),
            const Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}
