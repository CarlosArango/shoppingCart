import 'products.dart';

class ProductCart {
  String id;
  String cartId;
  Product product;
  int quantity;
  double? total;

  ProductCart({
    required this.id,
    required this.cartId,
    required this.product,
    required this.quantity,
    this.total,
  });

  ProductCart copyWith({
    String? id,
    String? cartId,
    Product? product,
    int? quantity,
    double? total,
  }) =>
      ProductCart(
        id: id ?? this.id,
        cartId: cartId ?? this.cartId,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        total: quantity! * product!.price,
      );

  factory ProductCart.fromJson(Map<String, Object?> json) => ProductCart(
        id: json["id"]! as String,
        cartId: json["cart_id"]! as String,
        product: Product.fromJson(json['product']),
        quantity: (json['quantity'] as num).toInt(),
        total: (json['quantity'] as num).toInt() *
            Product.fromJson(json['product']).price,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "product": product.toJson(),
        "quantity": quantity,
      };
}
