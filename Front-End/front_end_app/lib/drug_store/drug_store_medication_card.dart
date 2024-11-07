import 'package:flutter/material.dart';

import 'drug_store_medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({required this.medication, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          medication.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(medication.description),
        trailing: Text(
          '\$${medication.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        onTap: () {
          // TODO: Implement medication details page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You tapped on ${medication.name}')),
          );
        },
      ),
    );
  }
}
