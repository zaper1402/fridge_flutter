import 'package:fridge_app/core/constants/locale/locales_map.dart';
import 'package:get/get.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => 
     localKeyAndLocaleNameMap;
}
