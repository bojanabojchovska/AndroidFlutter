import 'package:flutter/material.dart';
import 'package:mis/models/joke_type.dart';
import 'package:mis/widgets/joke_type_card.dart';

class JokeTypeGrid extends StatelessWidget {
  final List<JokeType> jokeTypes;

  const JokeTypeGrid({super.key, required this.jokeTypes});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(4),
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      childAspectRatio: 200 / 244,
      shrinkWrap: true,
      children: jokeTypes.map((jokeType) {
        // Pass the entire jokeType object if required by JokeTypeCard
        return JokeTypeCard(jokeType: jokeType);
      }).toList(),
    );
  }
}
