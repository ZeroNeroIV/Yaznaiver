import 'package:flutter/material.dart';
import 'package:yaznaiver/home/home_app_bar.dart';
import 'package:yaznaiver/home/home_content.dart';

class HomeScaffold extends StatefulWidget {
  final Locale currentLanguage;
  final Function(Locale) changeLocale;

  const HomeScaffold({
    super.key,
    required this.currentLanguage,
    required this.changeLocale,
  });

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(
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
        ),
        Positioned(
          top: 30,
          right: 20,
          child: widget.currentLanguage == const Locale('ar')
              ? FloatingActionButton(
                  onPressed: () => widget.changeLocale(const Locale('en')),
                  child: const Text(
                    "English",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : FloatingActionButton(
                  onPressed: () => widget.changeLocale(const Locale('ar')),
                  child: const Text(
                    "العربية",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
        )
      ],
    );
  }
}
