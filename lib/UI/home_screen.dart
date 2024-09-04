
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/Models/product.dart';
import 'package:shopping_app/Views/cart_viewModel.dart';

class HomeScreen extends ConsumerWidget {
  final List<Product> products = [
    Product(
      name: 'Classic Shirt',
      basePrice: 50.0,
      sizes: ['Small', 'Medium', 'Large'],
      colors: ['Red', 'Green', 'Blue'],
      imageUrl: 'https://via.placeholder.com/150/0000FF/808080?text=Classic+Shirt',
    ),
    Product(
      name: 'Modern Jacket',
      basePrice: 120.0,
      sizes: ['Small', 'Medium', 'Large'],
      colors: ['Black', 'Gray', 'White'],
      imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Modern+Jacket',
    ),
    Product(
      name: 'Sport Shoes',
      basePrice: 75.0,
      sizes: ['8', '9', '10', '11'],
      colors: ['Red', 'Black', 'White'],
      imageUrl: 'https://via.placeholder.com/150/FFFF00/000000?text=Sport+Shoes',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartViewModel = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Cart: ${cartItems.length}'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Product List
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                String selectedSize = product.sizes.first;
                String selectedColor = product.colors.first;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(product.imageUrl, height: 150),
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price: \$${product.basePrice.toStringAsFixed(2)}'),
                            ElevatedButton(
                              onPressed: () {
                                cartViewModel.addToCart(product, selectedSize, selectedColor);
                              },
                              child: Text('Add to Cart'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Size Dropdown
                            DropdownButton<String>(
                              value: selectedSize,
                              items: product.sizes.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  selectedSize = value;
                                }
                              },
                            ),
                            SizedBox(width: 20),
                            // Color Dropdown
                            DropdownButton<String>(
                              value: selectedColor,
                              items: product.colors.map((color) {
                                return DropdownMenuItem(
                                  value: color,
                                  child: Text(color),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  selectedColor = value;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          // Cart Section
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl, width: 50),
                  title: Text('${item.product.name} (${item.selectedSize}, ${item.selectedColor})'),
                  subtitle: Text('Quantity: ${item.quantity}, Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
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
                          cartViewModel.addToCart(item.product, item.selectedSize, item.selectedColor);
                        },
                      ),
                    ],
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