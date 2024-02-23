import 'package:bloc/bloc.dart';
import '../repositories/daily_pictures_repository.dart';
import '../models/daily_pictures_model.dart';

class DailyPicturesBloc extends Bloc<dynamic, DailyPicturesModel> {
  final PhotoRepository photoRepository;

  DailyPicturesBloc({required this.photoRepository}) : super(DailyPicturesModel(
    title: '',
    explanation: '',
    imageUrl: '',
    hdImageUrl: '',
  ));

  Stream<DailyPicturesModel> mapEventToState(dynamic event) async* {
    yield await photoRepository.getPhotoOfTheDay();
  }
}
