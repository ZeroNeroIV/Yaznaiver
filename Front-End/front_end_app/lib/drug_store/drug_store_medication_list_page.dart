import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/drug_store/drugs_samples.dart';
import 'package:yaznaiver/drug_store/drug_store_cart_page.dart';
import 'package:yaznaiver/drug_store/drug_store_cart_item.dart';
import 'package:yaznaiver/drug_store/drug_store_medication_card.dart';

class MedicationListPage extends StatelessWidget {
  final List<CartItem> cart = [];

  MedicationListPage() : super(key: const Key('MedicationListPage'));

  void addToCart(CartItem item) {
    final existingItem = cart.firstWhere(
      (element) => element.medicine.brandName == item.medicine.genericName,
      orElse: () => CartItem(medicine: item.medicine),
    );
    if (!cart.contains(existingItem)) {
      cart.add(item);
    } else {
      existingItem.quantity += item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.shop_medicines),
        backgroundColor: const Color(0xFF29A7C0),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String searchQuery = '';
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.search_medicine),
                    content: TextField(
                      onChanged: (value) {
                        searchQuery = value;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_medicine_name,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Implement the search logic using `searchQuery`
                          print('${AppLocalizations.of(context)!.search_for}: $searchQuery');
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(AppLocalizations.of(context)!.search),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];
            return MedicineCard(
              medicine: medicine,
              onAddToCart: (quantity) => addToCart(CartItem(medicine: medicine, quantity: quantity)),
            );
          },
        ),
      ),
    );
  }
}
