import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:url_launcher/url_launcher.dart';
import '../API/api_manager.dart';
import '../Repository/auth_repository.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;

class LiveStreamController extends GetxController{
  final authRepository = AuthRepository(APIManager());
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);

  startYouTubeLiveStream({required String accessToken}) async {
    var liveStreamData= await authRepository.startYouTubeLiveStreamAPICall(
        accessToken:accessToken);
    if(liveStreamData.accessToken != "") {
      successSnackBar(message:'Live Stream started successfully.');
      getStreamID(accessToken);
      print('Live Stream started successfully.}');
    }else{
      print('Error starting live stream');
      errorSnackBar(message: "The user is not enabled for live streaming.");

    }
  }

  /// SignIn with google
  signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
      print("Current User Data..........................${googleSignIn.currentUser}");
      // GoogleSignInAccount? account = YouTubeApiManager().googleSignIn.currentUser;
      GoogleSignInAccount? account = googleSignIn.currentUser;
      if (account != null) {
        Map<String, String> authHeaders = await account.authHeaders;
        String accessToken = authHeaders["Authorization"] ?? "";
        await startYouTubeLiveStream(accessToken:accessToken);
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  /// Get Access Token
  Future<String?> getAccessToken() async {
    GoogleSignInAccount? account = googleSignIn.currentUser;
    if (account != null) {
      Map<String, String> authHeaders = await account.authHeaders;
      return authHeaders["Authorization"];
    }
    return null;
  }

  // Create a Client for refreshing auth client
  Future<void> createClient(String accessToken) async {
    auth.AccessCredentials credentials = auth.AccessCredentials(
      auth.AccessToken('Bearer', accessToken, DateTime.now().toUtc().add(Duration(hours: 1))),
      null,
      ['https://www.googleapis.com/auth/youtube.force-ssl'],
    );

    try {
      auth.AutoRefreshingAuthClient client = await auth.autoRefreshingClient(
        auth.ClientId(
          '935842735899-i1pui5tdt05l47pgk8hivltimfrsamjn.apps.googleusercontent.com',
          '',
        ),
        credentials,
        http.Client(),
      );


    } catch (e) {
      print('Error creating client: $e');
    }
  }



  Future<void> getStreamID(String? accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${APIManager.baseUrl}liveBroadcasts?part=snippet,contentDetails,status&key=YOUR_API_KEY'),
        headers: {
          'Authorization': accessToken ?? "",
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "snippet": {
            "title": "My Live Stream",
            "description": "A live stream from Flutter app",
          },
          "status": {
            "privacyStatus": "public",
          },
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String streamId = data['id'];
        print('Live Stream started successfully. Stream ID: $streamId');
        successSnackBar(message: 'Live Stream started successfully. Stream ID: $streamId');
        /// get a live stream url
        final String liveStreamUrl = data['items'][0]['cdn']['ingestionInfo']['ingestionAddress'];
        print('Live Stream URL: $liveStreamUrl');
        /// redirect to live
        launchYouTubeLiveStream(liveStreamUrl);
      } else {
        print('Error starting live stream: ${response.statusCode}');
        print('Response body: ${response.body}');
        errorSnackBar(title: "${response.statusCode}", message: "Error starting live stream.");
      }
    } catch (e) {
      print('Exception: $e');
      errorSnackBar(message: "Exception occurred: $e");
    }
  }

  /// redirect to live url
  Future<void> launchYouTubeLiveStream(String liveStreamUrl) async {
    if (await canLaunch(liveStreamUrl)) {
      await launch(liveStreamUrl);
      print("Live UrL .............$liveStreamUrl");
    } else {
      print('Could not launch $liveStreamUrl');
    }
  }
}

