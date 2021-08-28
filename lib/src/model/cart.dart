import 'user.dart';

enum CartStatus { pending, completed }

class Cart {
  String? id;
  User? user;
  double? total;
  CartStatus? status;

  Cart({
    required this.id,
    this.user,
    required this.total,
    this.status,
  });

  Cart copyWith({
    String? id,
    User? user,
    double? total,
    CartStatus? status,
  }) =>
      Cart(
        id: id ?? this.id,
        user: user ?? this.user,
        total: total ?? this.total,
        status: status ?? this.status,
      );

  factory Cart.fromJson(Map<String, Object?> json) => Cart(
        id: json["id"]! as String,
        user: User(
          id: json['user_id'] as String,
        ),
        total: (json['total'] as num).toDouble(),
        status: mapStringToCartStatus(json['status'] as String),
      );

  String emunToString(dynamic anyEnum) {
    return anyEnum.toString().split(".").last;
  }

  String serviceTypeToString(CartStatus cartStatus) => emunToString(cartStatus);

  static CartStatus mapStringToCartStatus(String cartStatus) {
    switch (cartStatus) {
      case "pending":
        return CartStatus.pending;
      case "completed":
        return CartStatus.completed;
      default:
        return CartStatus.pending;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": serviceTypeToString(status!),
        "total": total,
        "user_id": user?.id,
      };
}
