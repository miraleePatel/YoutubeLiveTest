import 'package:flutter/material.dart';
import 'package:get/get.dart';


String baseUrl = "https://youtube.googleapis.com/youtube/v3/";
String access_token = "access_token";

///
/// Snackbar for showing error message
///
errorSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Error',
        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.0, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(
        seconds: 3,
      ),
    ),
  );
}

///
/// Snackbar for showing success message
///
successSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.0, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.0, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.withOpacity(0.80),
      icon: const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

///
/// Snackbar for showing information message
///

informationSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.cyan.withOpacity(0.90),
      icon: const Icon(Icons.info_outline_rounded,
          size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}
