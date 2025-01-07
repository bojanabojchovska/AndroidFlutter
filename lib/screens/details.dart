import 'package:flutter/material.dart';
import 'package:mis/provider/joke_provider.dart';
import 'package:provider/provider.dart';
import '../models/joke_type.dart';
import '../services/api_service.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late JokeType jokeType;
  List<String> jokes = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jokeType = ModalRoute.of(context)?.settings.arguments as JokeType;
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    try {
      final fetchedJokes = await ApiService.getJokesForType(jokeType.type.toLowerCase());
      setState(() {
        jokes = fetchedJokes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(jokeType.type),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : jokes.isEmpty
          ? const Center(child: Text("No jokes found."))
          : ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final joke = jokes[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(joke),
            trailing: IconButton(
              icon: Icon(
                favoritesProvider.isFavorite(joke)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoritesProvider.isFavorite(joke) ? Colors.red : null,
              ),
              onPressed: () {
                favoritesProvider.toggleFavorite(joke);
              },
            ),
          );
        },
      ),
    );
  }
}
