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