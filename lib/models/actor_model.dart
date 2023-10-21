class ActorModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  ActorModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }

  map(Null Function(dynamic actor) param0) {}
}