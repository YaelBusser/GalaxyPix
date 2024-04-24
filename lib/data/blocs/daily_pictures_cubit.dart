import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:galaxypix/data/repositories/daily_pictures_repository.dart';

class PicturesCubit extends Cubit<DailyPicturesModel> {
  PicturesCubit(this.photoRepo)
      : super(DailyPicturesModel(
            title: '',
            explanation: '',
            imageUrl: '',
            hdImageUrl: '',
            date: ''));

  final PhotoRepository photoRepo;

  Future<void> loadPictureDay() async {
    try {
      final picture = await photoRepo.getPhotoOfTheDay();
      emit(picture);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class PicturesBetweenDatesCubit extends Cubit<List<DailyPicturesModel>> {
  final PhotoRepository photoRepo;

  PicturesBetweenDatesCubit(this.photoRepo) : super([]);

  Future<void> loadPicturesBetweenDates(
      DateTime startDate, DateTime endDate) async {
    try {
      final pictures =
          await photoRepo.getPhotosBetweenDates(startDate, endDate);
      emit(pictures);
    } catch (e) {
      throw Exception(e);
    }
  }
}
