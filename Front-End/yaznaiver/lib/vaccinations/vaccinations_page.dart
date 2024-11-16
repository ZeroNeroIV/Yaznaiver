import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/vaccinations/vaccinations_content.dart';

class VaccinationsPage extends StatelessWidget {
  const VaccinationsPage() : super(key: const Key('VaccinationsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.vaccination),
        centerTitle: true,
      ),
      body: const VaccinationsContent(),
    );
  }
}
