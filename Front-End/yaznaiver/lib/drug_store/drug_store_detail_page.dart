import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/drug_store/drug_store_medicine.dart';

class MedicineDetailPage extends StatefulWidget {
  final Medicine medicine;
  final void Function(int) onAddToCart;

  const MedicineDetailPage({super.key, required this.medicine, required this.onAddToCart});

  @override
  _MedicineDetailPageState createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine.genericName),
        backgroundColor: const Color(0xFF29A7C0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.medicine.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Generic Name and Generic Name
            Text(
              widget.medicine.genericName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${AppLocalizations.of(context)!.generic_name}: ${widget.medicine.genericName}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const Divider(),
            const SizedBox(height: 16),

            // Description
            Text(
              '${AppLocalizations.of(context)!.description}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.description),
            const Divider(),
            const SizedBox(height: 16),

            // Active Ingredient
            Text(
              '${AppLocalizations.of(context)!.active_ingredient}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.activeIngredient),
            const Divider(),
            const SizedBox(height: 16),

            // Inactive Ingredients
            Text(
              '${AppLocalizations.of(context)!.inactive_ingredient}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.inactiveIngredients.join(', ')),
            const Divider(),
            const SizedBox(height: 16),

            // Indications and Usage
            Text(
              '${AppLocalizations.of(context)!.indications_and_usage}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.indicationsAndUsage),
            const Divider(),
            const SizedBox(height: 16),

            // Warnings
            Text(
              '${AppLocalizations.of(context)!.warnings}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.warnings),
            const Divider(),
            const SizedBox(height: 16),

            // Adverse Reactions
            Text(
              '${AppLocalizations.of(context)!.adverse_reactions}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.adverseReactions.join(', ')),
            const Divider(),
            const SizedBox(height: 16),

            // Dosage and Administration
            Text(
              '${AppLocalizations.of(context)!.dosage_and_administration}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.dosageAndAdministration),
            const Divider(),
            const SizedBox(height: 16),

            // Manufacturer Name
            Text(
              '${AppLocalizations.of(context)!.manufacturer}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.manufacturerName),
            const Divider(),
            const SizedBox(height: 16),

            // Storage and Handling
            Text(
              '${AppLocalizations.of(context)!.storage_and_handling}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.storageAndHandling),
            const Divider(),
            const SizedBox(height: 16),

            // Product NDC
            Text(
              '${AppLocalizations.of(context)!.product_ndc}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.productNdc),
            const Divider(),
            const SizedBox(height: 16),

            // Route
            Text(
              '${AppLocalizations.of(context)!.route}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.route),
            const Divider(),
            const SizedBox(height: 16),

            // Do Not Use
            Text(
              '${AppLocalizations.of(context)!.do_not_use}:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.medicine.doNotUse),
            const Divider(),
            const SizedBox(height: 16),

            // Price: Only show if `buy == true`
            if (widget.medicine.buy == true) ...[
              Text(
                '${AppLocalizations.of(context)!.price}: \$${widget.medicine.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
            ],

            // Quantity Control

            // Add to Cart Button: Only show if `buy == true`
            if (widget.medicine.buy == true) ...[
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() => quantity = (quantity > 1) ? quantity - 1 : 1),
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => quantity++),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF29A7C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  widget.onAddToCart(quantity);
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.add_to_cart,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
