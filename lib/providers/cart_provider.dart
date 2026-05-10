import 'package:flutter/material.dart';
import '../data/database/db_helper.dart';
import '../data/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  double _total = 0.0;

  List<Map<String, dynamic>> get items => _items;
  double get total => _total;

  CartProvider() {
    loadCart();
  }

  Future<void> loadCart() async {
    _items = await DBHelper.getCartItems();
    _calculateTotal();
    notifyListeners();
  }

  void _calculateTotal() {
    _total = _items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  Future<void> addToCart(Product product) async {
    final item = {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
    };
    await DBHelper.addToCart(item);
    await loadCart();
  }

  Future<void> updateQuantity(int id, int quantity) async {
    await DBHelper.updateCartQuantity(id, quantity);
    await loadCart();
  }

  Future<void> removeFromCart(int id) async {
    await DBHelper.removeFromCart(id);
    await loadCart();
  }

  Future<void> clearCart() async {
    await DBHelper.clearCart();
    await loadCart();
  }
}
