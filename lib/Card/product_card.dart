import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatelessWidget {
  final dynamic product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              product['thumbnail'],
              fit: BoxFit.cover,
              width: double.infinity, 
              height: 200, 
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Text(
              product['category'],
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Text(
              product['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < product['rating'] ? Icons.star : Icons.star_outline,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Text(
              product['description'],
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product['price']} €',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  tooltip: 'Add to cart',
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}