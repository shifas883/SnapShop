import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapshop/screens/cart_page.dart';
import 'package:snapshop/screens/profile_screen.dart';
import 'package:snapshop/screens/wishlist_page.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = [
    FetchDataFromFirebase(),
    WishlistPage(),
    CartPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'SnapShop',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xff0D6EFD),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff0D6EFD),
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
