import 'package:shopping_app/Models/product.dart';

class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;
  final double price;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.price,
    this.quantity = 1,
  });
}