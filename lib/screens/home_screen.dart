import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_in_flutter/models/user.dart';
import 'package:testing_in_flutter/provider/favorites_provider.dart';
import 'package:testing_in_flutter/services/api.dart';
import 'package:http/http.dart' as http;

import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api api;
  http.Client client;
  Future<List<User>> futureUsers;
  @override
  void initState() {
    super.initState();
    var api = Api();
    client = http.Client();
    futureUsers = api.fetchUsers(client);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sample'),
        actions: <Widget>[
          FlatButton.icon(
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPage.routeName);
            },
            icon: Icon(Icons.favorite_border),
            label: Text('Favorites'),
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> users = snapshot.data;
              return ListView.builder(
                itemCount: users.length,
                cacheExtent: 20.0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) => ItemTile(
                  users[index],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ItemTile extends StatelessWidget {
  final User user;

  const ItemTile(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<FavoritesProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[user.id % Colors.primaries.length],
        ),
        title: Text(
          user.name,
        ),
        subtitle: Text('Phone: ${user.phone}\nMail: ${user.email}'),
        isThreeLine: true,
        trailing: IconButton(
          icon: favoritesList.items.contains(user)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(user)
                ? favoritesList.add(user)
                : favoritesList.remove(user);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(user)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
