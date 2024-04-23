import 'package:flutter/material.dart';
import 'ui/screens/home.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Erreur 404 : Page non trouvée !'),
            ),
          ),
        );
    }
  }
}
