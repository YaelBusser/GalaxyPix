import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/ui/screens/home.dart';
import 'package:http/http.dart' as http;

import 'data/blocs/daily_pictures_bloc.dart';
import 'data/repositories/daily_pictures_repository.dart';

void main() {
  final DailyPicturesRepository repository = DailyPicturesRepository(
    apiUrl: 'https://api.nasa.gov/planetary/apod?api_key=tBkgBTz9BfwgAH4Y3jXf1sEAdfMgdmZZ2SkENFj4',
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final DailyPicturesRepository repository;

  MyApp({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DailyPicturesBloc(repository: repository)..add(FetchDailyPicture()),
        child: HomePage(),
      ),
    );
  }
}
