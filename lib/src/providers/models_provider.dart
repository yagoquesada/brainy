import 'package:flutter/cupertino.dart';

import 'package:tfg_v3/src/features/generators/models/models_model.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-4";
  bool hasMemory = true;

  List<ModelsModel> modelsList = [];

  String get getCurrentModel {
    return currentModel;
  }

  void setMemoryEnabled(bool enabled) {
    hasMemory = enabled;
    notifyListeners();
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> get getModelsList {
    return modelsList;
  }
}
