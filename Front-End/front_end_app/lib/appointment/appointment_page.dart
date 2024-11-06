import 'package:flutter/material.dart';

import 'appointment_content.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage() : super(key: const Key('AppointmentPage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
      ),
      body: const AppointmentContent(),
    );
  }
}
