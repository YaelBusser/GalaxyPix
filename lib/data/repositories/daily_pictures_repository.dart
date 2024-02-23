// photo_repository.dart
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/daily_pictures_model.dart';

class PhotoRepository {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;

  PhotoRepository({required this.apiService, required this.sharedPreferences});

  Future<DailyPicturesModel> getPhotoOfTheDay() async {
    final savedDailyPicture = sharedPreferences.getString('saved_photo');
    var logger = Logger();

    if (savedDailyPicture != null) {
      logger.d('Using saved photo');
      return DailyPicturesModel.fromJson(json.decode(savedDailyPicture));
    } else {
      final photo = await apiService.getPhotoOfTheDay();
      print('Fetched new photo: $photo');
      sharedPreferences.setString('saved_photo', json.encode(photo.toJson()));
      return photo;
    }
  }

}
