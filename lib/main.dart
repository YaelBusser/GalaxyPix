// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/blocs/daily_pictures_cubit.dart';
import 'package:galaxypix/data/repositories/daily_pictures_repository.dart';
import 'package:galaxypix/ui/screens/splash.dart';
import 'app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  final photoRepo = PhotoRepository();
  final picturesCubit = PicturesCubit(photoRepo);

  picturesCubit.loadPictureDay();

  final picturesBetweenDatesCubit = PicturesBetweenDatesCubit(photoRepo);

  final startDate = DateTime.now().subtract(const Duration(days: 10));
  final endDate = DateTime.now();
  await picturesBetweenDatesCubit.loadPicturesBetweenDates(startDate, endDate);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider<PicturesCubit>(
                  create: (_) => picturesCubit,
                ),
                BlocProvider<PicturesBetweenDatesCubit>(
                  create: (_) => picturesBetweenDatesCubit,
                ),
              ],
              child: const MyApp(),
            ),
          ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter.routes,
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
