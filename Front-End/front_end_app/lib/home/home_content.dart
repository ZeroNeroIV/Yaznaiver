import 'package:flutter/material.dart';

import 'home_upcoming_appointments.dart';
import 'home_content_welcome.dart';
import 'home_quick_actions.dart';

class HomeContant extends StatelessWidget {
  const HomeContant() : super(key: const Key('HomeContent'));

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HomeContentWelcome(),
        SizedBox(height: 20),
        HomeQuickActions(),
        SizedBox(height: 20),
        HomeUpcomingAppointments(),
      ],
    );
  }
}
