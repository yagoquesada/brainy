import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "User",
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Settings",
  ),
];

List<RiveAsset> sideMenu2 = [
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat Generator",
  ),
  RiveAsset(
    "assets/rive/icons.riv",
    artboard: "REFRESH/RELOAD",
    stateMachineName: "RELOAD_Interactivity",
    title: "Image Generator",
  ),
];
