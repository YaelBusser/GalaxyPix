import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxypix/data/models/daily_pictures_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../data/blocs/daily_pictures_cubit.dart';
import '../widgets/menu.dart';
import 'home.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Découvrir'),
      ),
      body: BlocBuilder<PicturesBetweenDatesCubit, List<DailyPicturesModel>>(
        builder: (context, dailyPicturesList) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectStartDate(context);
                    },
                    child: const Text('Sélectionner la date de début'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Date de début: ${_formatDate(startDate)}'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectEndDate(context);
                    },
                    child: const Text('Sélectionner la date de fin'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Date de fin: ${_formatDate(endDate)}'),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _loadPhotosBetweenDates();
                },
                child: const Text('Rechercher'),
              ),
              if (dailyPicturesList.isEmpty)
                const CircularProgressIndicator()
              else
                const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(dailyPicturesList.length, (index) {
                      return Hero(
                          tag: "picture-$index",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: dailyPicturesList[index]
                                      .imageUrl
                                      .contains('youtube')
                                  ? MediaQuery.of(context).size.width - 20
                                  : MediaQuery.of(context).size.width / 2 - 15,
                              height: 250,
                              child: Stack(
                                children: [
                                  dailyPicturesList[index]
                                          .imageUrl
                                          .contains('youtube')
                                      ? YoutubePlayer(
                                          controller: YoutubePlayerController(
                                            initialVideoId: _extractVideoId(
                                                dailyPicturesList[index]
                                                    .imageUrl),
                                            flags: const YoutubePlayerFlags(
                                                autoPlay: true,
                                                mute: false,
                                                hideControls: false,
                                                controlsVisibleAtStart: false,
                                                showLiveFullscreenButton:
                                                    false),
                                          ),
                                          showVideoProgressIndicator: true,
                                          aspectRatio: 16 / 9,
                                          width: 400)
                                      : Image.network(
                                          dailyPicturesList[index].imageUrl,
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: 250,
                                        ),
                                  Positioned(
                                    bottom: dailyPicturesList[index]
                                            .imageUrl
                                            .contains('youtube')
                                        ? null
                                        : 0,
                                    left: 0,
                                    right: 0,
                                    top: dailyPicturesList[index]
                                            .imageUrl
                                            .contains('youtube')
                                        ? 0
                                        : null,
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: Text(
                                        dailyPicturesList[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          );
        },
      ),
      drawer: Menu(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        isHomePage: false,
        isDiscoverPage: true,
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final pickedStartDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedStartDate != null) {
      setState(() {
        startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final pickedEndDate = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedEndDate != null) {
      setState(() {
        endDate = pickedEndDate;
      });
    }
  }

  void _loadPhotosBetweenDates() {
    context
        .read<PicturesBetweenDatesCubit>()
        .loadPicturesBetweenDates(startDate, endDate);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _extractVideoId(String url) {
    final regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw ArgumentError('Invalid YouTube URL');
    }
  }
}
