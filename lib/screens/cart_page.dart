import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:snapshop/common_widgets/button.dart';
import 'package:snapshop/screens/order_summery.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    loadCart();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    // _razorpay.on(Razorpay.PAYMENT_CANCELLED, _handlePaymentCancelled);
  }

  void loadCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    setState(() {
      cartItems = cart.map((item) => json.decode(item) as Map<String, dynamic>).toList();
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderSummaryPage(cartItems: cartItems)),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      print("Payment Error: ${response.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? 'Payment Error')));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed")),
    );
  }

  // Handle payment cancellation
  // void _handlePaymentCancelled(PaymentCancelledResponse response) {
  //   print("Payment Cancelled");
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Payment Cancelled")),
  //   );
  // }

  // Function to initiate Razorpay payment
  void initiatePayment() {
    var options = {
      'key': 'your_key', // Replace with your Razorpay API Key
      'amount': (getTotalAmount() * 100).toString(), // Amount in paise (not rupees)
      'name': 'Your Store',
      'description': 'Product Description',
      'prefill': {'email': 'test@example.com', 'contact': '1234567890'},
      'theme': {'color': '#F37254'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error in Razorpay payment: $e');
    };
    _razorpay.open(options);
  }

  // Calculate total amount in the cart
  double getTotalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConfirmButton(text: 'Place Order (\$${getTotalAmount()})',
              onTap: initiatePayment,),
          ),
        ],
      ),
    );
  }
}
