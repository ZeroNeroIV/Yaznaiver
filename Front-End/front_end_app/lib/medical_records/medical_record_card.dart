import 'package:flutter/material.dart';

class MedicalRecordCard extends StatelessWidget {
  final String recordType;
  final String date;
  final String doctor;
  final String notes;

  const MedicalRecordCard({
    required this.recordType,
    required this.date,
    required this.doctor,
    required this.notes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recordType,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Date: $date'),
            Text('Doctor: $doctor'),
            const SizedBox(height: 8.0),
            Text('Notes: $notes'),
          ],
        ),
      ),
    );
  }
}
