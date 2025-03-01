import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/locale/localizations.dart';
import 'package:fridge_app/firebase_options.dart';
import 'package:fridge_app/routing/initial_binding.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fridge',
        translations: AppLocalization(),
            supportedLocales: const [
              Locale("en"),
            ],
            locale: const Locale("'en_US'"),
            fallbackLocale: const Locale("en_US"),
        theme: ThemeData(
            fontFamily: fontFamilyPoppins,
            appBarTheme: const AppBarTheme(iconTheme: IconThemeData(size: 12)),
            textTheme: const TextTheme(
            ).apply(
              bodyColor: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.pressed)) {
                //return color_F8FBF4;
              }
              return null;
            })))),
        getPages: routingData,
        initialBinding: ControllerBinding(),
        initialRoute: NameRoutes.splashScreen);
  }
}
