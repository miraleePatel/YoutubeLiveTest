import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Controller/live_stream_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LiveStreamController liveStreamController = Get.put(LiveStreamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Youtube Live Streaming",style: TextStyle(fontSize: 15.sp),),backgroundColor: Colors.purpleAccent[50],
      elevation: 3,),
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          await  liveStreamController.signInWithGoogle();
        },
        child: Text("Live Streaming"),
      ),
    ));
  }
}
