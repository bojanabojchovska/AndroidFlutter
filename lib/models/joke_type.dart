
class JokeType {
  final String type;
  Set<String> favoriteJokes = {};

  JokeType({required this.type});

  factory JokeType.fromJson(String data) => JokeType(type: data);
}
