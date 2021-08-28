class Product {
  String id;
  String name;
  String description;
  String sku;
  double price;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.sku,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? sku,
    double? price,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        sku: sku ?? this.sku,
        price: price ?? this.price,
      );

  factory Product.fromJson(json) => Product(
        id: json["id"]! as String,
        name: json["name"]! as String,
        description: json!["description"] ?? "N/A",
        sku: json["sku"] ?? "N/A",
        price: (json!['price'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "sku": sku,
        "price": price,
      };
}
