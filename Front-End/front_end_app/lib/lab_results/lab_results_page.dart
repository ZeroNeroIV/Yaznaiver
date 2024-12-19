import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/lab_results/lab_results_content.dart';

class LabResultsPage extends StatelessWidget {
  const LabResultsPage() : super(key: const Key('LabResultsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.lab_results),
        centerTitle: true,
      ),
      body: const LabResultsContent(),
    );
  }
}
