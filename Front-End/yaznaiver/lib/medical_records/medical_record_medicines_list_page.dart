import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/medical_records/medical_record_medicine_details_page.dart';

class MedicinesListPage extends StatelessWidget {
  final int patientId;

  const MedicinesListPage({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    // Sample medicine list
    List<String> medicines = [
      'Vitamin D supplement',
      'Pain reliever'
    ];

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.medicines)),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(medicines[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicineDetailsPage(medicine: medicines[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
