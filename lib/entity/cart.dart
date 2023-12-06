import 'dart:convert';

class Cart {
  final int? id;
  int? id_user, id_car, day, price;
  String? carName;
  DateTime? pickup_date, return_date;
  bool isReviewed;

  Cart({
    this.id,
    required this.id_user,
    required this.id_car,
    required this.day,
    required this.price,
    required this.carName,
    required this.pickup_date,
    required this.return_date,
    this.isReviewed = false,
  });

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));
  factory Cart.fromJson(Map<String, dynamic> json) {
    print('isReviewed value from JSON: ${json['isReviewed']}');
    return Cart(
      id: json['id'],
      id_user: json['id_user'],
      id_car: json['id_car'],
      day: json['day'],
      price: json['price'],
      carName: json['carName'],
      pickup_date: DateTime.parse(json['pickup_date']),
      return_date: DateTime.parse(json['return_date']),
      isReviewed: json['isReviewed'] == 1 || json['isReviewed'] == true,
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'id_car': id_car,
        'day': day,
        'price': price,
        'carName': carName,
        'pickup_date': pickup_date!.toIso8601String(),
        'return_date': return_date!.toIso8601String(),
        'isReviewed': isReviewed ? true : false,
      };
}
