import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Game> fetchGame(String) async {
  final response = await http.get(Uri.parse(
      'https://api.boardgameatlas.com/api/search?order_by=amazon_rank&ascending=true&client_id=nBnztxyFk8'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Game.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Game {
  final String id;
  final String name;
  final double price; //note: there is also an msrp variable
  final int minPlayers;
  final int maxPlayers;
  final int minPlaytime;
  final int maxPlaytime;
  final String description; //also a description_preview
  //thumb_url
  //image_url
  final String publisher;
  final String designer;
  final int amazonRank;
  final int numUserRatings;
  final double averageUserRating;

  Game(
      {required this.id,
      required this.name,
      required this.price,
      required this.minPlayers,
      required this.maxPlayers,
      required this.minPlaytime,
      required this.maxPlaytime,
      required this.description,
      required this.publisher,
      required this.designer,
      required this.amazonRank,
      required this.numUserRatings,
      required this.averageUserRating});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        minPlayers: json['min_players'],
        maxPlayers: json['max_players'],
        minPlaytime: json['min_playtime'],
        maxPlaytime: json['max_playtime'],
        description: json['description'],
        publisher: json['publisher'],
        designer: json['designer'],
        amazonRank: json['amazon_rank'],
        numUserRatings: json['num_user_rating'],
        averageUserRating: json['average_user_rating']);
  }
}
