import 'package:flutter/material.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class AboutMeText extends StatelessWidget {
  const AboutMeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            YTexts.heyThere.toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          YHelperFunctions.addVerticalSpace(10),
          Text(
            YTexts.aboutMeText,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
          YHelperFunctions.addVerticalSpace(20),
          Text(
            YTexts.contactMe,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          YHelperFunctions.addVerticalSpace(5),
          ListTile(
            leading: const Icon(
              Icons.phone_outlined,
              size: 35,
            ),
            title: Text(
              YTexts.myPhoneNumber,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              size: 35,
            ),
            title: Text(
              YTexts.myEmail,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
