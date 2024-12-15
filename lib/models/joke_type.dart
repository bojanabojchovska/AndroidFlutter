
class JokeType {
  final String type;

  JokeType({required this.type});

  factory JokeType.fromJson(String data) => JokeType(type: data);
}
