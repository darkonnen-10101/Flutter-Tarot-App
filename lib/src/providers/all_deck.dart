import 'package:flutter/widgets.dart';

class AllDeck with ChangeNotifier {
  bool _allDeck = false;
  bool _onlyUpright = false;

  bool get onlyUpright => _onlyUpright;

  set onlyUpright(bool value) {
    _onlyUpright = value;
    notifyListeners();
  }

  bool get allDeck => _allDeck;

  set allDeck(bool value) {
    _allDeck = value;
    notifyListeners();
  }
}
