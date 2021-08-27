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

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
