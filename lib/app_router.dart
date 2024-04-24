import 'package:galaxypix/ui/screens/discover.dart';

import 'ui/screens/home.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String discoverPage = '/discover';

  static final routes = {
    homePage: (context) => const HomeScreen(),
    discoverPage: (context) => const DiscoverScreen(),
  };
}
