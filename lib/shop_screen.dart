import 'package:flutter/material.dart';
import 'package:flutterapp/Card/product_card.dart';
import 'package:flutterapp/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopScreen extends StatefulWidget {
  final List<CartItem> cartItems; // Ajouter le paramètre cartItems

  const ShopScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  Set<dynamic> products = {};

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        products = Set.from(data['products']);
      });
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  void addToCart(dynamic product) {
    setState(() {
      final String? image = product['thumbnail'];
      final String? name = product['title'];
      final double? price = product['price'];

      if (image != null && name != null && price != null) {
        final newItem = CartItem(
          image: image,
          name: name,
          price: price,
          quantity: 1,
        );
        widget.cartItems.add(newItem); // Utiliser widget.cartItems pour accéder à la liste
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        primary: false,
        itemCount: products.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          final product = products.toList()[index];

          return ProductCard(
            product: product,
            onAddToCart: addToCart,
          );
        },
      ),
    );
  }
}