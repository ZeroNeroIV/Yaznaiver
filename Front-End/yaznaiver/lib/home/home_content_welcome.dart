import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class HomeContentWelcome extends StatelessWidget {
  const HomeContentWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '${AppLocalizations.of(context)!.welcome}, USER',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Sequel",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.how_can_we_assist_you_today,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: "Sequel",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
