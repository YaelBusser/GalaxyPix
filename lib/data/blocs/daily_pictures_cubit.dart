import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:galaxypix/data/repositories/daily_pictures_repository.dart';

class PicturesCubit extends Cubit<DailyPicturesModel> {
  PicturesCubit(this.photoRepo)
      : super(DailyPicturesModel(
            title: '', explanation: '', imageUrl: '', hdImageUrl: ''));

  final PhotoRepository photoRepo;

  Future<void> loadPictureDay() async {
    try {
      final picture = await photoRepo.getPhotoOfTheDay();
      emit(picture);
    } catch (e) {
      // Gérer l'erreur
    }
  }
}
