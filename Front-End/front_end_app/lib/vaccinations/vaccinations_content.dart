import 'package:flutter/material.dart';

import 'vaccination_card.dart';

class VaccinationsContent extends StatelessWidget {
  const VaccinationsContent() : super(key: const Key('VaccinationsContent'));

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Vaccination History',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16.0),
        const VaccinationCard(
          vaccineName: 'COVID-19 Vaccine',
          date: '2023-05-15',
          manufacturer: 'Pfizer',
        ),
        const VaccinationCard(
          vaccineName: 'Influenza Vaccine',
          date: '2023-01-10',
          manufacturer: 'GlaxoSmithKline',
        ),
        const VaccinationCard(
          vaccineName: 'Tetanus Booster',
          date: '2022-08-22',
          manufacturer: 'Sanofi Pasteur',
        ),
      ],
    );
  }
}
