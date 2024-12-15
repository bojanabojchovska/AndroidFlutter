import 'package:flutter/material.dart';
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
    // Retrieve JokeType argument from navigation
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
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(jokes[index]),
          );
        },
      ),
    );
  }
}
