import 'package:flutter/material.dart';
import 'package:mis/provider/joke_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteJokes = favoritesProvider.favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.heart_broken, size: 50),
            SizedBox(height: 10),
            Text("You've no favorites yet."),
          ],
        ),
      )
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(joke),
            trailing: const Icon(Icons.favorite, color: Colors.red),
          );
        },
      ),
    );
  }
}
