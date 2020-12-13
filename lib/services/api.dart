import 'dart:convert';

import 'package:testing_in_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<User>> fetchUsers(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      Iterable usersResponse = jsonDecode(response.body);
      var users =
          List<User>.from(usersResponse.map((json) => User.fromJson(json)));
      return users;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
