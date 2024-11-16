import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:intl/intl.dart';

class MedicalRecordCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const MedicalRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          record['record_type'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(
            DateTime.parse(record['date']),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppLocalizations.of(context)!.doctor}: ${record['doctor']}'),
                const SizedBox(height: 8),
                Text('${AppLocalizations.of(context)!.notes}: ${record['notes']}'),
                if (record['medications'] != null) ...[
                  const SizedBox(height: 8),
                  const Text('Medications:'),
                  ...record['medications'].map<Widget>((med) => Text('- $med')).toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
