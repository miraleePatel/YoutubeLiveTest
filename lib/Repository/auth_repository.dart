import 'package:get/get.dart';
import '../API/api_manager.dart';
import '../Model/live_streaming_model.dart';


class AuthRepository {
  final APIManager apiManager;

  AuthRepository(this.apiManager);

 
  Future<LoginSuccessModel> startYouTubeLiveStreamAPICall({required String accessToken}) async {
    final jsonData = await apiManager.getAPICall(url : "${APIManager.baseUrl}liveStreams?mine=true&key=AIzaSyCPRh3I0o0ea7kSxnTMy4xyEqAJSNTk8KA HTTP/1.1" ,accessToken:accessToken);

    var respons = LoginSuccessModel.fromJson(jsonData);
    return respons;
  }
}
