import 'package:get/get.dart';
import '../API/api_manager.dart';
import '../Model/live_broadcasts_model.dart';
import '../Model/live_streaming_model.dart';


class AuthRepository {
  final APIManager apiManager;

  AuthRepository(this.apiManager);

 
  Future<LoginSuccessModel> startYouTubeLiveStreamAPICall({required String accessToken}) async {
    final jsonData = await apiManager.getAPICall(url : "${APIManager.baseUrl}liveStreams?mine=true&key=AIzaSyCPRh3I0o0ea7kSxnTMy4xyEqAJSNTk8KA HTTP/1.1" ,accessToken:accessToken);

    var respons = LoginSuccessModel.fromJson(jsonData);
    return respons;
  }

  // LiveBroadcastsModel
  Future<LiveBroadcastsModel> liveBroadcastAPICall({
    required String accessToken
  }) async {
    var jsonData = await apiManager.postAPICall(
        url : '${APIManager.baseUrl}liveBroadcasts?part=snippet,contentDetails,status&key=AIzaSyC_sNbGPVecLc324FdJO__KjEgzZ3oooR0',
        accessToken:accessToken,
        params : {
    "snippet": {
    "title": "My Live Stream",
    "description": "A live stream from Flutter app",
    "scheduledStartTime":
    "2024-01-15T12:00:00Z", // Replace with the desired start time
    },
    "status": {
    "privacyStatus": "public",
    },
    }

    );
    var response = LiveBroadcastsModel.fromJson(jsonData);

    return response;
  }
}
