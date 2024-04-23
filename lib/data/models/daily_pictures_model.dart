class DailyPictureModel {
  final String title;
  final String explanation;
  final String imageUrl;

  DailyPictureModel({required this.title, required this.explanation, required this.imageUrl});

  factory DailyPictureModel.fromJson(Map<String, dynamic> json) {
    return DailyPictureModel(
      title: json['title'],
      explanation: json['explanation'],
      imageUrl: json['hdurl'],
    );
  }
}
