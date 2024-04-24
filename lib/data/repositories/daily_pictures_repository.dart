import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:http/http.dart';

class PhotoRepository {
  Future<DailyPicturesModel> getPhotoOfTheDay() async {
    final apodKey = dotenv.env["APOD_API_KEY"];
    final Response response = await get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=${apodKey.toString()}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return DailyPicturesModel(
          title: responseData['title'],
          explanation: responseData['explanation'],
          imageUrl: responseData['url'],
          hdImageUrl: responseData['hdurl']);
    } else {
      throw Exception('Failed to load photo');
    }
  }
}
