class User {
  String? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  User copyWith({
    String? id,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
