import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PaymentPage extends StatelessWidget {
  final double totalAmount;

  const PaymentPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.payment_page),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.under_maintainence)
          ],
        ),
      ),
    );
  }
}
