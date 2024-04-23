import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/daily_pictures_model.dart';

class DailyPicturesRepository {
  final String apiUrl;

  DailyPicturesRepository({required this.apiUrl});

  Future<DailyPictureModel> getDailyPicture() async {
    final response = await http.get(apiUrl as Uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return DailyPictureModel.fromJson(data);
    } else {
      throw Exception('Failed to load daily picture');
    }
  }
}
