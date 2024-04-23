// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/blocs/daily_pictures_cubit.dart';
import 'package:galaxypix/data/repositories/daily_pictures_repository.dart';
import 'package:galaxypix/ui/screens/home.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final photoRepo = PhotoRepository();
  final picturesCubit = PicturesCubit(photoRepo);

  await picturesCubit.loadPictureDay();

  runApp(BlocProvider(create: (_) => picturesCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GalaxyPix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter().onGenerateRoute,
      home: const HomeScreen(),
    );
  }
}
