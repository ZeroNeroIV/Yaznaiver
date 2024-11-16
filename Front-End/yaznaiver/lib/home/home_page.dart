import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/home/home_scaffold.dart';

class HomePage extends StatefulWidget {
  final Locale currentLanguage;
  final void Function(Locale) changeLocale;

  const HomePage({
    required this.currentLanguage,
    required this.changeLocale,
  }) : super(key: const Key('HomePage'));

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        _showPopup = true;
      });
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('''
هذا نموذج أولي
THIS IS A PROTOTYPE
'''),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.go),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Display the loading screen
      return Scaffold(
        backgroundColor: Colors.black, // Dark background
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Enlarged Logo
              Image.asset(
                'assets/images/yaznaiver-black.png', // Add your logo to assets folder
                height: 400, // Adjust height
                width: 400, // Adjust width
                fit: BoxFit.contain, // Ensure image scales properly
              ),
              const SizedBox(height: 20),
              // Animated Progress Bar
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Display the main content
      if (_showPopup) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showAlertDialog();
          setState(() {
            _showPopup = false;
          });
        });
      }

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
        child: HomeScaffold(
          currentLanguage: widget.currentLanguage,
          changeLocale: widget.changeLocale,
        ),
      );
    }
  }
}
