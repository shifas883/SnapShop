import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, dynamic>> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  void loadWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];

    setState(() {
      wishlistItems = wishlist.map((item) => json.decode(item) as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading: Image.network(item['image']),
              title: Text(item['name']),
              subtitle: Text('Price: \$${item['price']}'),
            ),
          );
        },
      ),
    );
  }
}
