import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users/1'));
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon compte'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: userData.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userData['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Mon compte',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Prénom',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['firstName'],
                    decoration: InputDecoration(
                      hintText: userData['firstName'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Nom',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['lastName'],
                    decoration: InputDecoration(
                      hintText: userData['lastName'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Pseudo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['username'],
                    decoration: InputDecoration(
                      hintText: userData['username'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Téléphone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['phone'],
                    decoration: InputDecoration(
                      hintText: userData['phone'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['email'],
                    decoration: InputDecoration(
                      hintText: userData['email'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Adresse',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userData['address']['address'],
                    decoration: InputDecoration(
                      hintText: userData['address']['address'],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Code postal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              initialValue: userData['address']['postalCode'],
                              decoration: InputDecoration(
                                hintText: userData['address']['postalCode'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ville',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              initialValue: userData['address']['city'],
                              decoration: InputDecoration(
                                hintText: userData['address']['city'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}