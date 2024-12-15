import 'package:flutter/material.dart';
import 'package:mis/models/jokeType.dart';

class JokeTypeCard extends StatelessWidget {
  final JokeType jokeType;

  const JokeTypeCard({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: jokeType,
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                jokeType.type,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
