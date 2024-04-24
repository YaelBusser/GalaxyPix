import 'ui/screens/home.dart';

class AppRouter {
  static const String homePage = '/home';

  static final routes = {
    homePage: (context) => const HomeScreen(),
  };
}
