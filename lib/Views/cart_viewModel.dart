// lib/cart_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/Models/cart_items.dart';
import 'package:shopping_app/Models/product.dart';

// Cart state provider
final cartProvider = StateNotifierProvider<CartViewModel, List<CartItem>>((ref) => CartViewModel());

class CartViewModel extends StateNotifier<List<CartItem>> {
  CartViewModel() : super([]);

  // Add item to cart
  void addToCart(Product product, String size, String color) {
    double price = product.basePrice;

    if (size == 'Large') price += 10;
    if (color == 'Red') price += 5;

    state = [
      ...state,
      CartItem(product: product, selectedSize: size, selectedColor: color, price: price),
    ];
  }

  // Remove item from cart
  void removeFromCart(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }
}
