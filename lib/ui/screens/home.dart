// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/blocs/daily_pictures_cubit.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:galaxypix/ui/screens/discover.dart';

import '../widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9100a2),
        foregroundColor: Colors.white,
        title: const Text('Photographie du jour'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: BlocBuilder<PicturesCubit, DailyPicturesModel?>(
            builder: (context, dailyPicturesModel) {
              if (dailyPicturesModel == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(dailyPicturesModel.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 15),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(dailyPicturesModel.imageUrl)),
                    const SizedBox(height: 15),
                    Text(
                      dailyPicturesModel.explanation,
                      textAlign: TextAlign.justify,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
      drawer: Menu(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverScreen()));
        },
        isHomePage: true,
        isDiscoverPage: false,
      ),
    );
  }
}
