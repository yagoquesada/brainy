import 'package:flutter/material.dart';
import 'package:tfg_v3/src/app/configuration/pages/subscription_plans_screen.dart';
import 'package:tfg_v3/src/app/configuration/purchase_api.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/core/presentation/utils/helpers/helper_functions.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';

class CardFormScreen extends StatelessWidget {
  const CardFormScreen({super.key});

  final isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWdg(
        closeButton: true,
        darkModeButton: false,
        isChat: false,
        title: YTexts.subscriptionTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : () => fetchOffers(context),
              child: Text(
                YTexts.seePlans,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchOffers(BuildContext context) async {
    final offerings = await PurchaseApi.fetchOffers();

    if (context.mounted) YHelperFunctions.navigateToScreen(context, const SubscriptionPlansScreen());

    // if (offerings.isEmpty) {
    //   getSnackBar(YTexts.snap, YTexts.noPlans, true);
    // } else {
    //   final packages = offerings.map((offer) => offer.availablePackages).expand((pair) => pair).toList();

    //   if (context.mounted) YHelperFunctions.navigateToScreen(context, const SubscriptionPlansScreen());
    // }
  }
}
