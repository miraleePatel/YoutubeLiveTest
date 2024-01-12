// ignore_for_file: constant_identifier_Names

import 'package:get/get.dart';
import '../Screens/home_screen.dart';
import '../Screens/splash_screen.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL_ROUTE = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => const HomeScreen(),
    ),

  ];
}
