import 'package:flutter/material.dart';

class VaccinationCard extends StatelessWidget {
  final String vaccineName;
  final String date;
  final String manufacturer;

  const VaccinationCard({
    required this.vaccineName,
    required this.date,
    required this.manufacturer,
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
              vaccineName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Date: $date'),
            Text('Manufacturer: $manufacturer'),
          ],
        ),
      ),
    );
  }
}
