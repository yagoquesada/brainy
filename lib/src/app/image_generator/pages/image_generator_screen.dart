import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/app/image_generator/controllers/image_controller.dart';
import 'package:tfg_v3/src/app/image_generator/widgets/create_button.dart';
import 'package:tfg_v3/src/app/image_generator/widgets/image_screen_subtitles.dart';
import 'package:tfg_v3/src/app/image_generator/widgets/text_field_prompt.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';

import '../../../core/presentation/utils/constants/bool_constants.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  String _style = '';
  String _color = '';

  late List<bool> _itemStatusStyle;
  late List<String> _itemTypesStyle;

  late List<bool> _itemStatusColors;
  late List<String> _itemTypesColors;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _itemStatusStyle = YBools.itemStatusStyle;
    _itemTypesStyle = YTexts.itemTypesStyle;
    _itemStatusColors = YBools.itemStatusColors;
    _itemTypesColors = YTexts.itemTypesColors;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Ink gridViewColors(BuildContext context) {
    return Ink(
      width: YHelperFunctions.screenWidth(),
      height: 125,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView.count(
        primary: true,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2 / 4,
        children: List.generate(
          _itemStatusColors.length,
          (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  for (int indexBtn = 0; indexBtn < _itemStatusColors.length; indexBtn++) {
                    if (indexBtn == index) {
                      if (_itemStatusColors[indexBtn] == false) {
                        _itemStatusColors[indexBtn] = true;
                        _color = ', color ${_itemTypesColors[indexBtn]}';
                      } else {
                        _itemStatusColors[indexBtn] = false;
                        _color = '';
                      }
                    } else {
                      _itemStatusColors[indexBtn] = false;
                    }
                  }
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: _itemStatusColors[index] ? Theme.of(context).splashColor : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _itemTypesColors[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _itemStatusColors[index] ? Theme.of(context).unselectedWidgetColor : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Ink gridViewStyles(BuildContext context) {
    return Ink(
      width: YHelperFunctions.screenWidth(),
      height: 125,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView.count(
        primary: true,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2 / 4,
        children: List.generate(
          _itemStatusStyle.length,
          (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  for (int indexBtn = 0; indexBtn < _itemStatusStyle.length; indexBtn++) {
                    if (indexBtn == index) {
                      if (_itemStatusStyle[indexBtn] == false) {
                        _itemStatusStyle[indexBtn] = true;
                        _style = ', ${_itemTypesStyle[indexBtn]} style';
                      } else {
                        _itemStatusStyle[indexBtn] = false;
                        _style = '';
                      }
                    } else {
                      _itemStatusStyle[indexBtn] = false;
                    }
                  }
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: _itemStatusStyle[index] ? Theme.of(context).splashColor : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _itemTypesStyle[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _itemStatusStyle[index] ? Theme.of(context).unselectedWidgetColor : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: const AppBarWdg(
        title: YTexts.imageGenerator,
        darkModeButton: false,
        closeButton: true,
        isChat: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldPrompt(textEditingController: _textEditingController),
              YHelperFunctions.addVerticalSpace(20.0),
              const ImageScreenSubtitles(title: YTexts.imageScreenSubtitlesStyles),
              YHelperFunctions.addVerticalSpace(15.0),
              gridViewStyles(context),
              YHelperFunctions.addVerticalSpace(30.0),
              const ImageScreenSubtitles(title: YTexts.imageScreenSubtitlesColors),
              YHelperFunctions.addVerticalSpace(15.0),
              gridViewColors(context),
              YHelperFunctions.addVerticalSpace(30.0),
              CreateButton(
                imageController: imageController,
                textEditingController: _textEditingController,
                style: _style,
                color: _color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
