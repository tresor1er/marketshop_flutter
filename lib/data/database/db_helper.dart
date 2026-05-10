import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'marketshop.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            total REAL,
            itemCount INTEGER,
            customerName TEXT,
            customerPhone TEXT,
            customerAddress TEXT,
            customerCity TEXT
          )
        ''');
      },
    );
  }

  // Cart operations
  static Future<void> addToCart(Map<String, dynamic> item) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart', where: 'id = ?', whereArgs: [item['id']]);
    if (maps.isNotEmpty) {
      await db.update('cart', {'quantity': maps.first['quantity'] + 1}, where: 'id = ?', whereArgs: [item['id']]);
    } else {
      item['quantity'] = 1;
      await db.insert('cart', item, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return await db.query('cart');
  }

  static Future<void> updateCartQuantity(int id, int quantity) async {
    final db = await database;
    if (quantity > 0) {
      await db.update('cart', {'quantity': quantity}, where: 'id = ?', whereArgs: [id]);
    } else {
      await db.delete('cart', where: 'id = ?', whereArgs: [id]);
    }
  }

  static Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  // Order operations
  static Future<void> addOrder(Map<String, dynamic> order) async {
    final db = await database;
    await db.insert('orders', order);
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await database;
    return await db.query('orders', orderBy: 'id DESC');
  }
}
