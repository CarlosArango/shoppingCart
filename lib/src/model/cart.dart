import 'user.dart';

import 'products.dart';

enum CartStatus { pending, completed }

class Cart {
  String id;
  User user;
  double total;
  CartStatus status;

  Cart({
    required this.id,
    required this.user,
    required this.total,
    required this.status,
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
        user: User.fromJson(
          (json['user'] as User).toJson(),
        ),
        total: (json['total'] as num).toDouble(),
        status: CartStatus.pending,
      );
}
