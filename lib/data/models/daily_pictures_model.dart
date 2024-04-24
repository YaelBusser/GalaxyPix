class DailyPicturesModel {
  late String title;
  late String explanation;
  late String imageUrl;
  late String hdImageUrl;

  DailyPicturesModel({
    required this.title,
    required this.explanation,
    required this.imageUrl,
    required this.hdImageUrl,
  });
  factory DailyPicturesModel.fromJson(Map<String, dynamic> json) {
    return DailyPicturesModel(
      title: json['title'],
      explanation: json['explanation'],
      imageUrl: json['url'],
      hdImageUrl: json['hdurl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'explanation': explanation,
      'url': imageUrl,
      'hdurl': hdImageUrl,
    };
  }
}
