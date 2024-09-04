
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/Models/product.dart';
import 'package:shopping_app/Views/cart_viewModel.dart';

class HomeScreen extends ConsumerWidget {
  final Product sampleProduct = Product(
    name: 'Sample Product',
    basePrice: 50.0,
    sizes: ['Small', 'Medium', 'Large'],
    colors: ['Red', 'Green', 'Blue'],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartViewModel = ref.read(cartProvider.notifier);

    String selectedSize = sampleProduct.sizes.first;
    String selectedColor = sampleProduct.colors.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
      ),
      body: Column(
        children: [
          // Product details and variants
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sampleProduct.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Select Size:'),
                DropdownButton<String>(
                  value: selectedSize,
                  items: sampleProduct.sizes
                      .map((size) => DropdownMenuItem<String>(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedSize = value;
                    }
                  },
                ),
                SizedBox(height: 10),
                Text('Select Color:'),
                DropdownButton<String>(
                  value: selectedColor,
                  items: sampleProduct.colors
                      .map((color) => DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedColor = value;
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    cartViewModel.addToCart(sampleProduct, selectedSize, selectedColor);
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
          Divider(),
          // Cart items
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text('${item.product.name} (${item.selectedSize}, ${item.selectedColor})'),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      cartViewModel.removeFromCart(item);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}