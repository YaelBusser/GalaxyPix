import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galaxypix/app_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRouter.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF040026),
        child: Center(
          child: Image.asset(
            'assets/images/logo.jpg',
          ),
        ),
      ),
    );
  }
}
