import 'dart:convert';

import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:http/http.dart';

class PhotoRepository {
  Future<DailyPicturesModel> getPhotoOfTheDay() async {
    final Response response = await get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=tBkgBTz9BfwgAH4Y3jXf1sEAdfMgdmZZ2SkENFj4'));

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
