import 'package:flutter/material.dart';
import 'home_app_bar.dart';
import 'home_content.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold() : super(key: const Key('HomeScaffold'));

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      appBar: HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: HomeContant(),
          ),
        ),
      ),
    );
  }
}
