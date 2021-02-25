import 'package:flutter/widgets.dart';

class Temp with ChangeNotifier {
  String initial;
  var event;
  bool isReload = false;

  Temp() {
    _fetchSomething(initial);
  }

  void resetTemp() {
    event = null;
    notifyListeners();
  }

  void updateEvent(value) {
    event = value;
    notifyListeners();
  }

  Future<void> _fetchSomething(String nv) async {
    initial = nv;
  }
}
