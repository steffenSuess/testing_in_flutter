import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_in_flutter/models/user.dart';
import 'package:testing_in_flutter/provider/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = '/favorites_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => FavoriteItemTile(value.items[index]),
        ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final User user;

  const FavoriteItemTile(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[user.id % Colors.primaries.length],
        ),
        title: Text(
          user.name,
        ),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<FavoritesProvider>(context, listen: false).remove(user);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
