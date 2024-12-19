import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/medical_records/medical_record_card.dart';
import 'package:yaznaiver/medical_records/medical_record_medicines_list_page.dart';
import 'package:yaznaiver/medical_records/medical_record_patient_info_card.dart';

class MedicalRecordsContent extends StatefulWidget {
  const MedicalRecordsContent({Key? key}) : super(key: const Key('MedicalRecordsContent'));

  @override
  _MedicalRecordsContentState createState() => _MedicalRecordsContentState();
}

class _MedicalRecordsContentState extends State<MedicalRecordsContent> {
  Map<String, dynamic>? patientData;
  List<Map<String, dynamic>> medicalRecords = [];

  @override
  void initState() {
    super.initState();
    fetchSampleData();
  }

  void fetchSampleData() {
    patientData = {
      'first_name': 'FIRST_NAME',
      'last_name': 'LAST_NAME',
      'patient_id': 1,
      'date_of_birth': '1990-01-01',
      'gender': 'Male',
      'phone_number': '123-456-7890',
      'email': 'johndoe@example.com',
      'address': '123 Main Street, Springfield',
      'blood_type': 'O+',
      'insurance_provider': 'HealthCare Inc.',
      'insurance_policy_number': 'POL123456',
      'insurance_expiry_date': '2024-12-31',
      'emergency_contact': {
        'name': 'Jane Doe',
        'phone': '098-765-4321'
      },
      'allergies': 'Peanuts, Penicillin'
    };

    medicalRecords = [
      {
        'record_type': 'Checkup',
        'date': '2024-10-01',
        'doctor': 'Dr. Smith',
        'notes': 'Routine checkup. No significant issues.',
        'medications': [
          'Vitamin D supplement'
        ]
      },
      {
        'record_type': 'Blood Test',
        'date': '2024-09-15',
        'doctor': 'Dr. Adams',
        'notes': 'Blood test results normal.',
        'medications': null
      },
      {
        'record_type': 'Follow-up',
        'date': '2024-09-01',
        'doctor': 'Dr. Brown',
        'notes': 'Follow-up for minor injury. Healing well.',
        'medications': [
          'Pain reliever'
        ]
      },
    ];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return patientData == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PatientInfoCard(patientData: patientData!),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppLocalizations.of(context)!.medicines,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to medicines list page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicinesListPage(patientId: patientData!['patient_id']),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.view_medicines),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppLocalizations.of(context)!.medical_records,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicalRecords.length,
                  itemBuilder: (context, index) {
                    return MedicalRecordCard(record: medicalRecords[index]);
                  },
                ),
              ],
            ),
          );
  }
}
