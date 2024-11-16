import 'package:flutter/material.dart';

import 'package:yaznaiver/home/home_upcoming_appointments.dart';
import 'package:yaznaiver/home/home_content_welcome.dart';
import 'package:yaznaiver/home/home_quick_menu.dart';

class HomeContant extends StatelessWidget {
  const HomeContant() : super(key: const Key('HomeContent'));

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HomeContentWelcome(),
        SizedBox(height: 20),
        HomeQuickMenu(),
        SizedBox(height: 20),
        HomeUpcomingAppointments(),
      ],
    );
  }
}
