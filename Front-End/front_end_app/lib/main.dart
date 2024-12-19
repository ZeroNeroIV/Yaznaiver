import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yaznaiver/home/home_page.dart';
import 'package:yaznaiver/xray_viewer/xray_viewer_page.dart';
import 'package:yaznaiver/appointment/appointment_page.dart';
import 'package:yaznaiver/lab_results/lab_results_page.dart';
import 'package:yaznaiver/vaccinations/vaccinations_page.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_page.dart';
import 'package:yaznaiver/medical_records/medical_records_page.dart';
import 'package:yaznaiver/drug_store/drug_store_medication_list_page.dart';

void main() => runApp(const Yaznaiver());

class Yaznaiver extends StatefulWidget {
  const Yaznaiver() : super(key: const Key('Yaznaiver'));

  @override
  State<Yaznaiver> createState() => _YaznaiverState();
}

class _YaznaiverState extends State<Yaznaiver> {
  Locale _locale = const Locale('en');

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yaznaiver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: HomePage(
        currentLanguage: _locale,
        changeLocale: _changeLocale,
      ),
      initialRoute: '/',
      routes: {
        '/ai-assistant': (context) => const AIChatPage(),
        '/appointment': (context) => const AppointmentBookingPage(),
        '/lab-results': (context) => const LabResultsPage(),
        '/medical-records': (context) => const MedicalRecordsPage(),
        '/drug-store': (context) => MedicationListPage(),
        '/vaccinations': (context) => const VaccinationsPage(),
        '/x-ray-viewer': (context) => const XrayViewerPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
