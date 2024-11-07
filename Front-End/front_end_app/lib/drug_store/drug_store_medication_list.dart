import 'package:flutter/material.dart';

import 'drug_store_medication.dart';
import 'drug_store_medication_card.dart';

class MedicationList extends StatelessWidget {
  MedicationList() : super(key: const Key('MedicationList'));

  final List<Medication> medications = [
    Medication(
      name: 'Aspirin',
      description: 'Pain reliever and fever reducer',
      price: 5.99,
    ),
    Medication(
      name: 'Ibuprofen',
      description: 'Nonsteroidal anti-inflammatory drug',
      price: 7.49,
    ),
    Medication(
      name: 'Acetaminophen',
      description: 'Pain reliever and fever reducer',
      price: 6.99,
    ),
    Medication(
      name: 'Amoxicillin',
      description: 'Antibiotic',
      price: 12.99,
    ),
    Medication(
      name: 'Lisinopril',
      description: 'ACE inhibitor for high blood pressure',
      price: 8.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medications.length,
      itemBuilder: (context, index) {
        return MedicationCard(medication: medications[index]);
      },
    );
  }
}
