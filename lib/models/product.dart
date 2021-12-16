import 'package:afpa_demo_firebase/constants.dart';

class Product {
  final String ref;
  final String name;
  final double price;
  bool available;

  Product({
    required this.ref,
    required this.name,
    required this.price,
    required this.available
  });

  Map<String, dynamic> toMap() {
    return Map.from({
      PRODUCT_NAME: name,
      PRODUCT_PRICE: price,
      PRODUCT_AVAILABLE: available
    });
  }
}