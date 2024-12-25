import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapshop/common_widgets/button.dart';

class ProductDetailsPage extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isInWishlist = false;
  bool isAddedToCart = false;

  // Toggle wishlist status
  void toggleWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];

    String productJson = json.encode({
      'name': widget.product['name'],
      'image': widget.product['image'],
      'price': widget.product['price'],
    });

    if (isInWishlist) {
      wishlist.remove(productJson);  // Remove product from wishlist
    } else {
      wishlist.add(productJson);  // Add product to wishlist
    }

    // Save updated wishlist to SharedPreferences
    await prefs.setStringList('wishlist', wishlist);

    setState(() {
      isInWishlist = !isInWishlist;
    });

    // Show a snack bar indicating the action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isInWishlist ? 'Added to Wishlist!' : 'Removed from Wishlist!')),
    );
  }

  // Add product to cart
  void addToCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList('cart') ?? [];

    String productJson = json.encode({
      'name': widget.product['name'],
      'image': widget.product['image'],
      'price': widget.product['price'],
    });

    if (!cart.contains(productJson)) {
      cart.add(productJson);
      await prefs.setStringList('cart', cart);
      setState(() {
        isAddedToCart = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product is already in the cart!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Product Details"),
        actions: [
          IconButton(
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleWishlist,  // Toggle wishlist action
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.product['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product['name'],  // Display product name
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Price: \$${widget.product['price']}",  // Display product price
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 16),
              // "Add to Cart" Button
              ConfirmButton(
                text: isAddedToCart ? "Added to Cart" : "Add to Cart",
                onTap: addToCart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
