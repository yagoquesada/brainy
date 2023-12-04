import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/app/authentication/controllers/mail_verification_controller.dart';

import '../../../core/presentation/utils/constants/assets_strings.dart';
import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final mailVerificationController = Get.put(MailVerificationController());
    final accountController = Get.put(AccountController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      body: getBody(context, mailVerificationController, accountController),
    );
  }

  Stack getBody(BuildContext context, MailVerificationController mailVerificationController, AccountController accountController) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: -30,
          top: 500,
          child: Image.asset(
            YAssets.logoBrainy,
            height: 800,
            width: 800,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YHelperFunctions.addVerticalSpace(35),
              const Icon(Icons.mark_email_read_outlined, size: 140),
              YHelperFunctions.addVerticalSpace(20),
              Text(
                YTexts.titleMailVerification,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              YHelperFunctions.addVerticalSpace(20),
              Text(
                YTexts.mailVerification,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              YHelperFunctions.addVerticalSpace(15),
              Text(
                YTexts.mailVerificationText,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              YHelperFunctions.addVerticalSpace(35),
              OutlinedButton(
                onPressed: () => mailVerificationController.manuallyCheckEmailVerificationStatus(),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    side: BorderSide(width: 2, color: Theme.of(context).unselectedWidgetColor),
                    fixedSize: Size(YHelperFunctions.screenWidth() * 0.6, 60)),
                child: Text(
                  YTexts.ccontinue,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              YHelperFunctions.addVerticalSpace(12),
              TextButton(
                onPressed: () => mailVerificationController.sendVerificationEmail(),
                child: Text(
                  YTexts.resendEmail,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: YColors.primary),
                ),
              ),
              TextButton(
                onPressed: () => accountController.logout(),
                child: Text(
                  YTexts.backToLogin,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: YColors.primary),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
