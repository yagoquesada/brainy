import 'package:flutter/material.dart';
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
            "Hey there!!!".toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          addVerticalSpace(10),
          Text(
            "I'm Yago, a 21-year-old student at UPC. I created Brainy as my Bachelor's Final Project. It's an innovative app designed to learn and entertain using Artificial Intelligence (gpt-3.5-turbo-0301). Join me on this journey to a smarter and funnier world!!!",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
          addVerticalSpace(20),
          Text(
            "Contact Me:",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          addVerticalSpace(5),
          ListTile(
            leading: const Icon(
              Icons.phone_outlined,
              size: 35,
            ),
            title: Text(
              "(+34) 691 39 13 35",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              size: 35,
            ),
            title: Text(
              "brainycontactmail@gmail.com",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
