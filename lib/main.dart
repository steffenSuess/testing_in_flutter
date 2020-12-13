import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_in_flutter/provider/favorites_provider.dart';
import 'package:testing_in_flutter/screens/favorites_screen.dart';
import 'package:testing_in_flutter/screens/home_screen.dart';

void main() {
  runApp(TestingApp());
}

class TestingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesProvider>(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          FavoritesPage.routeName: (context) => FavoritesPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
