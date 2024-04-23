// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/blocs/daily_pictures_cubit.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photographie du jour'),
      ),
      body: BlocBuilder<PicturesCubit, DailyPicturesModel>(
        builder: (context, dailyPicturesModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(dailyPicturesModel.hdImageUrl),
              const SizedBox(height: 16),
              Text(
                dailyPicturesModel.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Text(dailyPicturesModel.explanation),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
