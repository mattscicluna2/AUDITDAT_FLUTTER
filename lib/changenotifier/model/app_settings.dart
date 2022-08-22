import 'package:flutter/foundation.dart';

class AppSettings extends ChangeNotifier {
  late bool _isOnline = true;

  bool get isOnline => _isOnline;

  set isOnline(bool value) {
    _isOnline = value;
    notifyListeners();
  }
}