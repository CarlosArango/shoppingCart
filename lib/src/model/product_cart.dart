import 'products.dart';

class ProductCart {
  String id;
  String cartId;
  Product product;
  int quantity;

  ProductCart({
    required this.id,
    required this.cartId,
    required this.product,
    required this.quantity,
  });

  ProductCart copyWith({
    String? id,
    String? cartId,
    Product? product,
    int? quantity,
  }) =>
      ProductCart(
        id: id ?? this.id,
        cartId: cartId ?? this.cartId,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
      );

  factory ProductCart.fromJson(Map<String, Object?> json) => ProductCart(
        id: json["id"]! as String,
        cartId: json["cart_id"]! as String,
        product: Product.fromJson(json['product']),
        quantity: (json['quantity'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "product": product.toJson(),
        "quantity": quantity
      };
}
