class DailyPicturesModel {
  late String title;
  late String explanation;
  late String imageUrl;
  late String hdImageUrl;
  late String date;

  DailyPicturesModel({
    required this.title,
    required this.explanation,
    required this.imageUrl,
    required this.hdImageUrl,
    required this.date
  });
  factory DailyPicturesModel.fromJson(Map<String, dynamic> json) {
    return DailyPicturesModel(
      title: json['title'],
      explanation: json['explanation'],
      imageUrl: json['url'],
      hdImageUrl: json['url'],
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'explanation': explanation,
      'url': imageUrl,
      'hdurl': hdImageUrl,
      'date': date
    };
  }
}
