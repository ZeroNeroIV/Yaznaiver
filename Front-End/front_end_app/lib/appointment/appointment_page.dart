import 'package:flutter/material.dart';

import 'appointment_content.dart';

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
        title: const Text('Book Appointment'),
      ),
      body: const AppointmentContent(),
    );
  }
}
