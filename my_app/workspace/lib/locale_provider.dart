import 'package:flutter/material.dart';
import 'package:my_app/l10n/support_locale.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale loc) {
    if (!L10n.support.contains(loc)) return;
    if (_locale == loc) return;
    _locale = loc;
    notifyListeners();
  }
  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}