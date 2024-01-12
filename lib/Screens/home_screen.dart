import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import '../Api/api_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Youtube Live Streaming",style: TextStyle(fontSize: 15.sp),),backgroundColor: Colors.purpleAccent[50],
      elevation: 3,),
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          await YouTubeApiManager().signInWithGoogle();
        },
        child: Text("Live Streaming"),
      ),
    ));
  }
}
