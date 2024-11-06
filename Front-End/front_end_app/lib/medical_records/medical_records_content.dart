import 'package:flutter/material.dart';

import 'medical_record_card.dart';

class MedicalRecordsContent extends StatelessWidget {
  const MedicalRecordsContent() : super(key: const Key('MedicalRecordsContent'));

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Medical Records',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16.0),
        const MedicalRecordCard(
          recordType: 'Blood Test',
          date: '2023-06-01',
          doctor: 'Dr. Smith',
          notes: 'All results within normal range',
        ),
        const MedicalRecordCard(
          recordType: 'Physical Examination',
          date: '2023-03-15',
          doctor: 'Dr. Johnson',
          notes: 'Patient in good health, recommended regular exercise',
        ),
        const MedicalRecordCard(
          recordType: 'Allergy Test',
          date: '2022-11-30',
          doctor: 'Dr. Brown',
          notes: 'Mild allergy to pollen detected',
        ),
      ],
    );
  }
}
