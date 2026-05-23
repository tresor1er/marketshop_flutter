import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/services/api_service.dart';
import '../data/models/product.dart';
import '../providers/cart_provider.dart';

const Map<String, String> categoryTranslations = {
  'electronics': 'Électronique',
  'jewelery': 'Bijouterie',
  "men's clothing": 'Vêtements Homme',
  "women's clothing": 'Vêtements Femme',
};

String translateCategory(String category) {
  return categoryTranslations[category] ?? category;
}

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ApiService _apiService = ApiService();
  Product? _product;
  bool _isLoading = true;
  String? _error;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    try {
      final product = await _apiService.getProduct(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement du produit.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail du produit')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: _product!.image,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(_product!.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${(_product!.price * 600).toStringAsFixed(0)} FCFA', style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              Text('${_product!.rating}', style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Chip(label: Text(translateCategory(_product!.category))),
                      const SizedBox(height: 16),
                      Text('Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_product!.description, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (_quantity > 1) {
                                setState(() => _quantity--);
                              }
                            },
                          ),
                          Text('$_quantity', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() => _quantity++);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                          onPressed: () async {
                            final cartProvider = Provider.of<CartProvider>(context, listen: false);
                            // Add logic to handle quantity (for now cart provider adds 1, we need to update it or add multiple)
                            // A better approach is to add item multiple times or update cartProvider to take quantity
                            for(int i=0; i<_quantity; i++){
                              await cartProvider.addToCart(_product!);
                            }
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Produit ajouté au panier')),
                            );
                          },
                          child: const Text('Ajouter au panier', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
