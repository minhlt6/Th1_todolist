import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  Locale? _locale;
  Color _backgroundColor = const Color(0xFFFFF8E1);

  Locale? get locale => _locale;
  Color get backgroundColor => _backgroundColor;

  void setLocale(Locale? newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}

final AppSettings settings = AppSettings();
