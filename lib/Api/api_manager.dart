import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_live/Utils/constants.dart';


class YouTubeApiManager {

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);

  /// startYouTubeLiveStream Api calling
  Future<void> startYouTubeLiveStream( String? accessToken) async {

    final response = await http.get(Uri.parse('${baseUrl}liveStreams?mine=true&key=AIzaSyCPRh3I0o0ea7kSxnTMy4xyEqAJSNTk8KA HTTP/1.1'),
        headers: {'Authorization': accessToken ?? "",
          'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Live Stream started successfully. Stream ID: ${data["id"]}');
      print(response.body);
      getStreamID(accessToken);
      successSnackBar(message:'Live Stream started successfully. Stream ID: ${data["id"]}');
      // You may want to save the stream ID or launch the YouTube app with the live stream URL.
    } else {
      print('Error starting live stream: ${response.statusCode}');
      print('Response body: ${response.body}');
      errorSnackBar(title:"${response.statusCode}",message: "The user is not enabled for live streaming.");
    }

  }

  Future<void> getStreamID(String? accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}liveBroadcasts?part=snippet,contentDetails,status&key=YOUR_API_KEY'),
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
  /// SignIn with google
  Future<void> signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
      print("Current User Data..........................${googleSignIn.currentUser}");
      // GoogleSignInAccount? account = YouTubeApiManager().googleSignIn.currentUser;
      GoogleSignInAccount? account = googleSignIn.currentUser;
      if (account != null) {
        Map<String, String> authHeaders = await account.authHeaders;
        String accessToken = authHeaders["Authorization"] ?? "";
        await startYouTubeLiveStream(accessToken);
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

/// Create a Client for refreshing auth client
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