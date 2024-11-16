import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/appointment/appointment_content.dart';

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage() : super(key: const Key('AppointmentBookingPage'));

  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.book_appointment),
      ),
      body: const AppointmentContent(),
    );
  }
}
