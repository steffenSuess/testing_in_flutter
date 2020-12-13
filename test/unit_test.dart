import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_in_flutter/json_strings.dart';
import 'package:testing_in_flutter/models/user.dart';
import 'package:testing_in_flutter/provider/favorites_provider.dart';
import 'package:http/http.dart' as http;
import 'package:testing_in_flutter/services/api.dart';

class MockClient extends Mock implements http.Client {}

main() {
  Api api = Api();
  List<User> testUsers = [
    User(id: 0, name: 'John Doe', username: 'john_doe', email: '', phone: ''),
    User(id: 1, name: 'Jane Doe', username: 'jane_doe', email: '', phone: ''),
  ];
  group('App Provider Tests', () {
    group('FavoritesProvider Tests', () {
      FavoritesProvider favorites;

      setUp(() {
        favorites = FavoritesProvider();
      });

      test('A new user should be added', () {
        var testUser = testUsers[0];
        favorites.add(testUser);
        expect(favorites.items.contains(testUser), true);
      });
      test('An user should be removed', () {
        testUsers.forEach((user) {
          favorites.add(user);
        });
        expect(favorites.items.length, 2);
        expect(favorites.items.contains(testUsers[0]), true);
        expect(favorites.items.contains(testUsers[1]), true);
        favorites.remove(testUsers[1]);
        expect(favorites.items.length, 1);
        expect(favorites.items.contains(testUsers[1]), false);
        expect(favorites.items.contains(testUsers[0]), true);
      });
    });
  });

  group('App Api Test', () {
    group('fetchUser', () {
      test('returns the Users if the http call completes successfully',
          () async {
        final client = MockClient();

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get('https://jsonplaceholder.typicode.com/users'))
            .thenAnswer(
                (_) async => http.Response(JsonStrings.listOfSampleUsers, 200));

        expect(await api.fetchUsers(client), isA<List<User>>());
      });

      test('throws an exception if the http call completes with an error', () {
        final client = MockClient();

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(client.get('https://jsonplaceholder.typicode.com/users'))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(api.fetchUsers(client), throwsException);
      });
    });
  });
}
