import 'package:flutter/material.dart';

import 'medical_records_content.dart';

class MedicalRecordsPage extends StatelessWidget {
  const MedicalRecordsPage() : super(key: const Key('MedicalRecordsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Records"),
        centerTitle: true,
      ),
      body: const MedicalRecordsContent(),
    );
  }
}
