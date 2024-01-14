import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'Routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Youtube Live',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL_ROUTE,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


