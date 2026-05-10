import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _address = '';
  String _city = '';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Commande')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Récapitulatif', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return ListTile(
                      title: Text(item['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('Quantité: ${item['quantity']}'),
                      trailing: Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total à payer: \$${cartProvider.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              Text('Informations de livraison', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom complet', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est obligatoire' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Téléphone', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ce champ est obligatoire';
                  if (int.tryParse(value) == null) return 'Veuillez entrer un numéro valide';
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresse', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est obligatoire' : null,
                onSaved: (value) => _address = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ville', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Ce champ est obligatoire' : null,
                onSaved: (value) => _city = value!,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      final order = {
                        'date': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                        'total': cartProvider.total,
                        'itemCount': cartProvider.items.fold(0, (sum, item) => sum + (item['quantity'] as int)),
                        'customerName': _name,
                        'customerPhone': _phone,
                        'customerAddress': _address,
                        'customerCity': _city,
                      };
                      
                      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
                      await orderProvider.addOrder(order);
                      await cartProvider.clearCart();
                      
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Commande confirmée !')));
                        context.go('/history');
                      }
                    }
                  },
                  child: const Text('Confirmer la commande', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
