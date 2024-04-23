import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/daily_pictures_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Picture'),
      ),
      body: BlocBuilder<DailyPicturesBloc, DailyPicturesState>(
        builder: (context, state) {
          if (state is DailyPicturesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DailyPicturesLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(state.picture.imageUrl),
                SizedBox(height: 20),
                Text(state.picture.title),
                SizedBox(height: 10),
                Text(state.picture.explanation),
              ],
            );
          } else if (state is DailyPicturesError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Container();
        },
      ),
    );
  }
}
