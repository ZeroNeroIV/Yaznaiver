import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        child: const Text(
          'YAZNAIVER',
          style: TextStyle(
            fontFamily: "Sequel",
            fontSize: 25,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottom: Tab(
        child: Text(
          AppLocalizations.of(context)!.your_personal_health_companion,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Sequel",
            fontSize: 12,
          ),
        ),
      ),
      toolbarHeight: kToolbarHeight + 25,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
