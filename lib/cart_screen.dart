import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
 @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      image: '../assets/pp.jpg',
      name: 'Produit 1',
      price: 25.00,
      quantity: 0,
    ),
    CartItem(
      image: '../assets/pp.jpg',
      name: 'Produit 2',
      price: 30.00,
      quantity: 0,
    ),
  ];

  int get totalArticles {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity;
    }
    return total;
  }

  double get totalPrice {
    double total = 0.00;
    for (var item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mon Panier',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalArticles articles',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Prix total : \€${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return buildCartItem(cartItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(CartItem item) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Prix : \€${item.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (item.quantity > 0) {
                  item.quantity--;
                }
              });
            },
          ),
          Text(
            item.quantity.toString(),
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                item.quantity++;
              });
            },
          ),
          SizedBox(width: 16.0),
          Text(
            'Total : \€${item.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String image;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get totalPrice {
    return price * quantity;
  }
}