import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:url_launcher/url_launcher.dart';
import '../API/api_manager.dart';
import '../Model/live_broadcasts_model.dart';
import '../Repository/auth_repository.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;

class LiveStreamController extends GetxController {
  final authRepository = AuthRepository(APIManager());
  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);

  /// SignIn with google
  Future<void> signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
      print(
          "Current User Data..........................${googleSignIn.currentUser}");
           GoogleSignInAccount? account = googleSignIn.currentUser;
      if (account != null) {
        Map<String, String> authHeaders = await account.authHeaders;
        String accessToken = authHeaders["Authorization"] ?? "";
        await startYouTubeLiveStream(accessToken: accessToken);
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  startYouTubeLiveStream({required String accessToken}) async {
    var liveStreamData = await authRepository.startYouTubeLiveStreamAPICall(
        accessToken: accessToken);

    if (accessToken != "") {
      successSnackBar(message: 'Live Stream started successfully.');
      getStreamID(accessToken);
      print('Live Stream started successfully.}');
    } else {
      print('Error starting live stream......');
      errorSnackBar(message: "The user is not enabled for live streaming.");
    }
  }


  /// Get Stream id for go to live
  getStreamID(String? accessToken) async {
    LiveBroadcastsModel liveBroadcastsModel = await authRepository
        .liveBroadcastAPICall(accessToken: accessToken ?? "");

    if (liveBroadcastsModel.id != null && liveBroadcastsModel.id != "") {
      print(
          'Live Stream started successfully. Stream ID: ${liveBroadcastsModel.id}');
      if (liveBroadcastsModel.id != null && liveBroadcastsModel.id != "") {
        /// get a live stream url
        var liveStreamUrl =
            'https://www.youtube.com/watch?v=${liveBroadcastsModel.id}';

        /// redirect to live
        await launchYouTubeLiveStream(liveStreamUrl);
      } else {
        print("error....................");
      }
    } else {
      errorSnackBar(message: "Error starting live stream.");
    }
  }

  /// redirect to live url
  Future<void> launchYouTubeLiveStream(String liveStreamId) async {
    try {
      launch(liveStreamId);
    } catch (e) {
      //To handle error and display error message
      errorSnackBar(message: "Unable to open LiveStream");
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
      auth.AccessToken('Bearer', accessToken,
          DateTime.now().toUtc().add(Duration(hours: 1))),
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
