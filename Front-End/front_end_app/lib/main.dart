import 'package:flutter/material.dart';
import 'ai_assistant/ai_assistant_page.dart';
import 'home/home_page.dart';
import 'drug_store/drug_store_page.dart';
import 'lab_results/lab_results_page.dart';
import 'medical_records/medical_records_page.dart';
import 'vaccinations/vaccinations_page.dart';
import 'appointment/appointment_page.dart';

void main() {
  runApp(const Yaznaiver());
}

class Yaznaiver extends StatelessWidget {
  const Yaznaiver() : super(key: const Key('Yaznaiver'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yaznaiver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/ai-assistant': (context) => const AiAssistantPage(),
        '/appointment': (context) => const AppointmentPage(),
        '/drug-store': (context) => const DrugStorePage(),
        '/': (context) => const HomePage(),
        '/lab-results': (context) => const LabResultsPage(),
        '/medical-records': (context) => const MedicalRecordsPage(),
        '/vaccinations': (context) => const VaccinationsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
