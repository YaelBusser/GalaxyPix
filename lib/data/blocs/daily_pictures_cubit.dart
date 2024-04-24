import 'package:deepl_dart/deepl_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:galaxypix/data/repositories/daily_pictures_repository.dart';

class PicturesCubit extends Cubit<DailyPicturesModel?> {
  PicturesCubit(this.photoRepo) : super(null);

  final PhotoRepository photoRepo;
  final deeplKey = dotenv.env["DEEPL_API_KEY"];

  Future<void> loadPictureDay() async {
    try {
      final picture = await photoRepo.getPhotoOfTheDay();
      Translator translator = Translator(
          authKey: deeplKey.toString(),
          serverUrl: "https://api-free.deepl.com");
      final titleTranslated =
          await translator.translateTextSingular(picture.title, 'fr');
      final explanationTranslated =
          await translator.translateTextSingular(picture.explanation, 'fr');

      picture.title = titleTranslated.text;
      picture.explanation = explanationTranslated.text;

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
