import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/daily_pictures_model.dart';
import '../repositories/daily_pictures_repository.dart';

// États possibles du bloc
abstract class DailyPicturesState {}

class DailyPicturesInitial extends DailyPicturesState {}

class DailyPicturesLoaded extends DailyPicturesState {
  final DailyPictureModel picture;

  DailyPicturesLoaded(this.picture);
}

class DailyPicturesError extends DailyPicturesState {
  final String errorMessage;

  DailyPicturesError(this.errorMessage);
}

// Événements possibles du bloc
abstract class DailyPicturesEvent {}

class FetchDailyPicture extends DailyPicturesEvent {}

class DailyPicturesBloc extends Bloc<DailyPicturesEvent, DailyPicturesState> {
  final DailyPicturesRepository repository;

  DailyPicturesBloc({required this.repository}) : super(DailyPicturesInitial());

  @override
  Stream<DailyPicturesState> mapEventToState(DailyPicturesEvent event) async* {
    if (event is FetchDailyPicture) {
      yield DailyPicturesInitial();
      try {
        final picture = await repository.getDailyPicture();
        yield DailyPicturesLoaded(picture);
      } catch (e) {
        yield DailyPicturesError('Failed to fetch daily picture: $e');
      }
    }
  }
}
