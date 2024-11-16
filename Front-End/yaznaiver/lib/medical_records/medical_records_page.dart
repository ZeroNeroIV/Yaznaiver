import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/medical_records/medical_records_content.dart';

class MedicalRecordsPage extends StatelessWidget {
  const MedicalRecordsPage({Key? key}) : super(key: const Key('MedicalRecordsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.medical_records),
        centerTitle: true,
      ),
      body: const MedicalRecordsContent(),
    );
  }
}
