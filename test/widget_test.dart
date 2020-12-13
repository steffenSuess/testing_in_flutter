import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_in_flutter/models/user.dart';
import 'package:testing_in_flutter/provider/favorites_provider.dart';
import 'package:testing_in_flutter/screens/favorites_screen.dart';
import 'package:testing_in_flutter/screens/home_screen.dart';

//TODO: implement widget tests

List<User> testUsers = [
  User(id: 0, name: 'John Doe', username: 'john_doe', email: '', phone: ''),
  User(id: 1, name: 'Jane Doe', username: 'jane_doe', email: '', phone: ''),
];
FavoritesProvider favorites;

Widget createHomeScreen() => ChangeNotifierProvider<FavoritesProvider>(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

Widget createFavoritesScreen() => ChangeNotifierProvider<FavoritesProvider>(
      create: (context) {
        favorites = FavoritesProvider();
        return favorites;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  testUsers.forEach((user) {
    favorites.add(user);
  });
}

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('John Doe'), findsOneWidget);
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text('John Doe'), findsNothing);
    });
    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.favorite), findsNothing);
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Added to favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
  group('Favorites Page Widget Tests', () {
    testWidgets('Test if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
