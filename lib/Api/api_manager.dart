import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
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
      successSnackBar(message:'Live Stream started successfully. Stream ID: ${data["id"]}');
      // You may want to save the stream ID or launch the YouTube app with the live stream URL.
    } else {
      print('Error starting live stream: ${response.statusCode}');
      print('Response body: ${response.body}');
      errorSnackBar(title:"${response.statusCode}",message: "The user is not enabled for live streaming.");
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
}