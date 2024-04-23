import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/daily_pictures_model.dart';

class ApiService {
  final String apiKey;
  final String apiUrl;

  ApiService({required this.apiKey, required this.apiUrl});

  Future<DailyPicturesModel> getPhotoOfTheDay() async {
    final response = await http.get('$apiUrl?api_key=$apiKey' as Uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return DailyPicturesModel.fromJson(data);
    } else {
      throw Exception('Failed to load pictures');
    }
  }
}
