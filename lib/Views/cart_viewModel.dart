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

    // Adjust price based on size or color selection (dummy logic for example)
    if (size == 'Large') price += 10;
    if (color == 'Red') price += 5;

    // Check if the item already exists in the cart
    final existingItemIndex = state.indexWhere((item) =>
        item.product.name == product.name &&
        item.selectedSize == size &&
        item.selectedColor == color);

    if (existingItemIndex >= 0) {
      // If it exists, increment the quantity
      state[existingItemIndex].quantity++;
    } else {
      // Add as new item
      state = [
        ...state,
        CartItem(product: product, selectedSize: size, selectedColor: color, price: price),
      ];
    }

    // Update state to trigger UI refresh
    state = List.from(state);
  }

  // Remove item from cart or decrement quantity
  void removeFromCart(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      state = state.where((cartItem) => cartItem != item).toList();
    }

    // Update state to trigger UI refresh
    state = List.from(state);
  }
}