
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/Models/product.dart';
import 'package:shopping_app/UI/cart_page.dart';
import 'package:shopping_app/Utils/app_colors.dart';
import 'package:shopping_app/Views/cart_viewModel.dart';

class HomeScreen extends ConsumerWidget {
  final List<Product> products = [
    Product(
      name: 'Classic Shirt',
      basePrice: 500.0,
      sizes: ['Small', 'Medium', 'Large'],
      colors: ['Red', 'Green', 'Blue'],
      imageUrl: 'https://smkollectionz.com/wp-content/uploads/2024/08/Checked-shirts-in-Kenya-300x300.jpg',
    ),
    Product(
      name: 'Modern Jacket',
      basePrice: 1200.0,
      sizes: ['Small', 'Medium', 'Large'],
      colors: ['Black', 'Gray', 'White'],
      imageUrl: 'https://smkollectionz.com/wp-content/uploads/2024/02/Men-Denim-Jackets-in-Nairobi-300x300.jpg',
    ),
    Product(
      name: 'Sport Shoes',
      basePrice: 750.0,
      sizes: ['8', '9', '10', '11'],
      colors: ['Red', 'Black', 'White'],
      imageUrl: 'https://smkollectionz.com/wp-content/uploads/2022/12/Chocolate-Brown-Men-Leopard-Rubber-Shoes-300x300.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartViewModel = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
        backgroundColor: Colors.grey[350],
        actions: [
          // Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 45,),
                onPressed: () {
                  // Navigate to the Cart Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
                return ProductCard(
                  product: product,
                  onAddToCart: (selectedSize, selectedColor) {
                    cartViewModel.addToCart(product, selectedSize, selectedColor);
                  },
                );
              },
            )),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(String size, String color) onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late String selectedSize;
  late String selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes.first;
    selectedColor = widget.product.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Column(children: [
            Image.network(widget.product.imageUrl, height: 150),
                  
                ],)),
                Expanded(child: Column(children: [
                  Text(
              widget.product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
                Text('Price: Ksh ${widget.product.basePrice.toStringAsFixed(2)}'),

                Row(
              children: [
                // Size Dropdown
                DropdownButton<String>(
                  value: selectedSize,
                  items: widget.product.sizes.map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedSize = value;
                      });
                    }
                  },
                ),
                const SizedBox(width: 20),
                // Color Dropdown
                DropdownButton<String>(
                  value: selectedColor,
                  items: widget.product.colors.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedColor = value;
                      });
                    }
                  },
                ),
              ],
            ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.5)
                  ),
                  onPressed: () {
                    widget.onAddToCart(selectedSize, selectedColor);
                  },
                  
                  child: const Text('Add to Cart', style: TextStyle(color: AppColors.backgroundColor),),
                ),

                ],))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}