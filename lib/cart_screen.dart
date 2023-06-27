import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalArticles = 0;
  double totalPrice = 00.00;
  int quantity = 0;
  double itemTotalPrice = 0.00;

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
                  'Prix total : \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Expanded(
            child: ListView(
              children: [
                buildCartItem(
                  image: 'assets/product_image1.png',
                  name: 'Produit 1',
                  price: 25.00,
                ),
                buildCartItem(
                  image: 'assets/product_image2.png',
                  name: 'Produit 2',
                  price: 30.00,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem({
    required String image,
    required String name,
    required double price,
  }) {

    void updateItemTotalPrice() {
      setState(() {
        itemTotalPrice = quantity * price;
      });
    }

    void incrementQuantity() {
      setState(() {
        quantity++;
        totalArticles++;
        totalPrice += price;
        updateItemTotalPrice();
      });
    }

    void decrementQuantity() {
      if (quantity > 0) {
        setState(() {
          quantity--;
          totalArticles--;
          totalPrice -= price;
          updateItemTotalPrice();
        });
      }
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
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
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Prix : \$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: decrementQuantity,
              ),
              Text(
                quantity.toString(),
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: incrementQuantity,
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Text(
            'Total : \$${itemTotalPrice.toStringAsFixed(2)}',
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
