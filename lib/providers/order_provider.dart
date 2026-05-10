import 'package:flutter/material.dart';
import '../data/database/db_helper.dart';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  OrderProvider() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    _orders = await DBHelper.getOrders();
    notifyListeners();
  }

  Future<void> addOrder(Map<String, dynamic> order) async {
    await DBHelper.addOrder(order);
    await loadOrders();
  }

  Future<void> clearAllData() async {
    // This is for the profile screen "Vider mes données"
    final db = await DBHelper.database;
    await db.delete('orders');
    await DBHelper.clearCart();
    await loadOrders();
  }
}
