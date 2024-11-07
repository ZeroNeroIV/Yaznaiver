import 'package:flutter/material.dart';
import 'drug_store_medication_list.dart';

class DrugStorePage extends StatelessWidget {
  const DrugStorePage() : super(key: const Key('DrugStorePage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug Store'),
      ),
      body: MedicationList(),
    );
  }
}
