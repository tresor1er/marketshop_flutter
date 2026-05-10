class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null && json['rating']['rate'] != null ? json['rating']['rate'].toDouble() : 0.0,
    );
  }
}
