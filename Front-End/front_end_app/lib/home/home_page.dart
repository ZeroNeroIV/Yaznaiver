import 'package:flutter/material.dart';
import 'home_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage() : super(key: const Key('HomePage'));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0xFF3498db),
            Color(0xFF1abc9c),
          ],
        ),
      ),
      child: const HomeScaffold(),
    );
  }
}
