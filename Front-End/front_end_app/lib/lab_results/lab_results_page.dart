import 'package:flutter/material.dart';

import 'lab_results_content.dart';

class LabResultsPage extends StatelessWidget {
  const LabResultsPage() : super(key: const Key('LabResultsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Results'),
        centerTitle: true,
      ),
      body: const LabResultsContent(),
    );
  }
}
