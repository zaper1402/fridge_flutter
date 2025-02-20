

import 'package:fridge_app/themes/text_theme/base_text_theme.dart';
import 'package:fridge_app/themes/text_theme/light_text_theme.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal() {
    _textTheme = LightTextTheme();
  }

  late BaseTextTheme _textTheme;

  BaseTextTheme get textTheme => _textTheme;

}

BaseTextTheme getTextTheme() {
  return AppTheme().textTheme;
}
