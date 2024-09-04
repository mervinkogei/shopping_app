// lib/cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/Views/cart_viewModel.dart';

class CartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartViewModel = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl, width: 50),
                  title: Text('${item.product.name} (${item.selectedSize}, ${item.selectedColor})'),
                  subtitle: Text(
                      'Quantity: ${item.quantity}, Total: Ksh ${(item.price * item.quantity).toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          cartViewModel.removeFromCart(item);
                        },
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () {
                          cartViewModel.addToCart(
                              item.product, item.selectedSize, item.selectedColor);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
