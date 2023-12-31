import 'package:flutter/material.dart';
import 'package:flutterapp/shop_screen.dart';
import 'package:flutterapp/account_screen.dart';
import 'package:flutterapp/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AccountScreen();
        break;
      case 1:
        page = ShopScreen(cartItems: cartItems); // Passer la liste cartItems
        break;
      case 2:
        page = CartScreen(cartItems: cartItems); // Passer la liste cartItems
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 1200,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.account_circle),
                      label: Text('Account'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.shopping_basket),
                      label: Text('Cart'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}