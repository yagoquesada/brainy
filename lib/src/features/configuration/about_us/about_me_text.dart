import 'package:flutter/material.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
            YTexts.tHeyThere.toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          addVerticalSpace(10),
          Text(
            YTexts.tAboutMeText,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
          addVerticalSpace(20),
          Text(
            YTexts.tContactMe,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          addVerticalSpace(5),
          ListTile(
            leading: const Icon(
              Icons.phone_outlined,
              size: 35,
            ),
            title: Text(
              YTexts.tMyPhoneNumber,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              size: 35,
            ),
            title: Text(
              YTexts.tMyEmail,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
