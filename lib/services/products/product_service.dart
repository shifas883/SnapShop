import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapshop/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection('products').add(productData);
      print("Product added successfully!");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

}


void main() async {
  final ProductService productService = ProductService();

  Map<String, dynamic> newProduct = {
    'name': 'Product A',
    'price': 20.0,
    'imageUrl': 'https://example.com/imageA.jpg',
    'isPromotional': true,
    'discount': 10
  };

  await productService.addProduct(newProduct);
}


void addMultipleProducts() async {
  final ProductService productService = ProductService();

  List<Map<String, dynamic>> products = [
    {
      'name': 'iPhone 15',
      'price': 50000.0,
      'image': 'https://img.xfinitymobile.com/image/fetch/e_trim/w_420,h_420,c_fit,f_auto,q_auto,fl_lossy/https%3A%2F%2Fimg.xfinitymobile.com%2Fimage%2Fupload%2Fv1694553714%2Fclient%2Fcatalog%2Fdevices%2Fapple%2FApple_iPhone-15_Green_PRI.png',
      'isPromotional': true,
      'discount': 10
    },
    {
      'name': 'Samsung S24',
      'price': 125000.0,
      'image': 'https://images-cdn.ubuy.co.in/668bc8ccaf1af725753d6b0e-samsunggalaxy-s24-ultra-512-gb-titanyum.jpg',
      'isPromotional': false
    },
    {
      'name': 'Airpods',
      'price': 20000.0,
      'image': 'https://www.maplestore.in/cdn/shop/files/AirPods_Max_Fall24_Orange_PDP_Image_Position_1__en-IN_3a8533f1-1d19-4c26-8d80-6fcc8c250b38.jpg?v=1727252269&width=1445',
      'isPromotional': false
    },
    {
      'name': 'Laptop Lenovo',
      'price': 100000.0,
      'image': 'https://cdn.thewirecutter.com/wp-content/media/2024/07/laptopsunder500-2048px-5452.jpg?auto=webp&quality=75&width=1024',
      'isPromotional': false
    },
  ];

  for (var product in products) {
    await productService.addProduct(product);
  }
}
