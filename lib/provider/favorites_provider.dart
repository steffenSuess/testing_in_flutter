import 'package:flutter/material.dart';
import 'package:testing_in_flutter/models/user.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class FavoritesProvider extends ChangeNotifier {
  final List<User> _favoriteItems = [];

  List<User> get items => _favoriteItems;

  void add(User user) {
    _favoriteItems.add(user);
    notifyListeners();
  }

  void remove(User user) {
    _favoriteItems.remove(user);
    notifyListeners();
  }
}
