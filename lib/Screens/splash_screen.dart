import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Routes/routes.dart';
import '../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToRoute();
    super.initState();
  }

  navigateToRoute() async {
    Future.delayed(
      const Duration(seconds: 3),
    ).then((value) async {
        Get.offAllNamed(Routes.HOME_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        Assets.assetsSplash,
        scale: 6,
      )),
    );
  }
}
