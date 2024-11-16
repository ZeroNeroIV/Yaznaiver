import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yaznaiver/medical_records/medical_record_patient_info_row.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PatientInfoCard extends StatelessWidget {
  final Map<String, dynamic> patientData;

  const PatientInfoCard({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${patientData['first_name']} ${patientData['last_name']}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            PatientInfoRow(icon: Icons.badge, text: '${AppLocalizations.of(context)!.id}: ${patientData['patient_id']}'),
            PatientInfoRow(icon: Icons.cake, text: '${AppLocalizations.of(context)!.date_of_birth}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(patientData['date_of_birth']))}'),
            PatientInfoRow(icon: Icons.person, text: '${AppLocalizations.of(context)!.gender}: ${patientData['gender']}'),
            PatientInfoRow(icon: Icons.phone, text: patientData['phone_number']),
            PatientInfoRow(icon: Icons.email, text: patientData['email']),
            PatientInfoRow(icon: Icons.home, text: patientData['address']),
            PatientInfoRow(icon: Icons.local_hospital, text: '${AppLocalizations.of(context)!.blood_type}: ${patientData['blood_type']}'),
            PatientInfoRow(icon: Icons.health_and_safety, text: '${AppLocalizations.of(context)!.insurance}: ${patientData['insurance_provider']}'),
            PatientInfoRow(icon: Icons.numbers, text: '${AppLocalizations.of(context)!.policy}: ${patientData['insurance_policy_number']}'),
            PatientInfoRow(
              icon: Icons.date_range,
              text: '${AppLocalizations.of(context)!.expiry_date}: ${patientData['insurance_expiry_date']}',
            ),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context)!.emergency_contact}:', style: Theme.of(context).textTheme.bodySmall),
            PatientInfoRow(icon: Icons.contact_phone, text: '${patientData['emergency_contact']['name']}: ${patientData['emergency_contact']['phone']}'),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context)!.allergies}:', style: Theme.of(context).textTheme.bodySmall),
            Text(patientData['allergies'], style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
