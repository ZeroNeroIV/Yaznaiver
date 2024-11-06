import 'package:flutter/material.dart';

import 'vaccinations_content.dart';

class VaccinationsPage extends StatelessWidget {
  const VaccinationsPage() : super(key: const Key('VaccinationsPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vaccination"),
        centerTitle: true,
      ),
      body: const VaccinationsContent(),
    );
  }
}
