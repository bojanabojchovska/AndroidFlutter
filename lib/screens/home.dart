import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mis/models/joke_type.dart';
import 'package:mis/screens/favorites.dart';
import '../services/api_service.dart';
import '../widgets/joke_type_grid.dart';
import 'package:mis/screens/random_joke.dart'; // Import the Random Joke screen
// Import the Favorites screen

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  void fetchJokeTypes() async {
    final response = await ApiService.getJokeTypesFromApi();
    setState(() {
      jokeTypes = (json.decode(response.body) as List)
          .map<JokeType>((type) => JokeType.fromJson(type))
          .toList();
    });
  }

  // Method to fetch and navigate to the Random Joke screen
  void fetchRandomJoke() async {
    try {
      String randomJoke = await ApiService.getRandomJoke();
      // Navigate to the RandomJokeScreen with the fetched joke
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RandomJokeScreen(joke: randomJoke),
        ),
      );
    } catch (e) {
      // Handle error if needed
      print('Failed to load random joke: $e');
    }
  }

  // Method to navigate to the Favorites screen
  void goToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoritesPage(), // Assuming you already implemented FavoritesPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: const Text(
          "Joke Types - 213089",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // Button for fetching random joke
          TextButton.icon(
            onPressed: fetchRandomJoke,
            icon: const Icon(Icons.sentiment_very_satisfied, color: Colors.white),
            label: const Text(
              "PUSH ME",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: JokeTypeGrid(jokeTypes: jokeTypes),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent[100],
        child: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.white),
          onPressed: goToFavorites, // Navigate to FavoritesPage
          tooltip: "Go to Favorites",
        ),
      ),
    );
  }
}
