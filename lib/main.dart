// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/ui/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';
import 'data/services/api_service.dart';
import 'data/repositories/daily_pictures_repository.dart';
import 'data/blocs/daily_pictures_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GalaxyPix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter().onGenerateRoute,
      home: BlocProvider(
        create: (context) => DailyPicturesBloc(
          photoRepository: PhotoRepository(
            apiService: ApiService(
                apiKey: 'tBkgBTz9BfwgAH4Y3jXf1sEAdfMgdmZZ2SkENFj4',
                apiUrl: 'https://api.nasa.gov/planetary/apod'),
            sharedPreferences: sharedPreferences,
          ),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
