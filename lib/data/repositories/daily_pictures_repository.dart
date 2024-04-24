import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:http/http.dart';

class PhotoRepository {
  Future<DailyPicturesModel> getPhotoOfTheDay() async {
    final Response response = await get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=${dotenv.env["APOD_API_KEY"].toString()}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return DailyPicturesModel(
          title: responseData['title'],
          explanation: responseData['explanation'],
          imageUrl: responseData['url'],
          hdImageUrl: responseData['hdurl'],
          date: responseData['date']);
    } else {
      throw Exception('Failed to load photo');
    }
  }

  Future<List<DailyPicturesModel>> getPhotosBetweenDates(
      DateTime startDate, DateTime endDate) async {
    String startDateString = startDate.toIso8601String().substring(0, 10);
    String endDateString = endDate.toIso8601String().substring(0, 10);
    String apiUrl = 'https://api.nasa.gov/planetary/apod';
    String apiKey = dotenv.env["APOD_API_KEY"].toString();
    String url =
        '$apiUrl?api_key=$apiKey&start_date=$startDateString&end_date=$endDateString';

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      List<DailyPicturesModel> photos = responseData.map((json) {
        return DailyPicturesModel(
            title: json['title'],
            explanation: json['explanation'],
            imageUrl: json['url'],
            hdImageUrl: json['url'],
            date: json['date']);
      }).toList();

      return photos;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
