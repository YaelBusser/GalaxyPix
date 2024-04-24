import 'package:flutter/material.dart';
import 'package:galaxypix/ui/screens/discover.dart';
import 'package:galaxypix/ui/screens/home.dart';

class Menu extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isHomePage;
  final bool isDiscoverPage;

  const Menu(
      {super.key,
      required this.onTap,
      required this.isHomePage,
      required this.isDiscoverPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: <Widget>[
          ListTile(
            title: Text(
              'Accueil',
              style: TextStyle(
                  color: isHomePage ? Colors.white : const Color(0xFF9100a2)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            tileColor: isHomePage ? const Color(0xFF9100a2) : null,
          ),
          ListTile(
            title: Text(
              'Découvrir',
              style: TextStyle(
                  color:
                      isDiscoverPage ? Colors.white : const Color(0xFF9100a2)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DiscoverScreen()));
            },
            tileColor: isDiscoverPage ? const Color(0xFF9100a2) : null,
          ),
        ],
      ),
    );
  }
}
