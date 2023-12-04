import 'package:flutter/cupertino.dart';

class MemoryProvider with ChangeNotifier {
  bool hasMemory = true;

  void setMemoryEnabled(bool enabled) {
    hasMemory = enabled;
    notifyListeners();
  }
}
