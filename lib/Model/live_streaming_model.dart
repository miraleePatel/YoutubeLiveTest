class YoutubeLiveStreamModel {
  final String id;
  final String title;
  final String description;

  YoutubeLiveStreamModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory YoutubeLiveStreamModel.fromJson(Map<String, dynamic> json) {
    return YoutubeLiveStreamModel(
      id: json['id'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
    );
  }
}


class LoginSuccessModel {
  String? accessToken;

  LoginSuccessModel({this.accessToken});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    return data;
  }
}