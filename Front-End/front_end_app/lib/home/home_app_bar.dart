import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar() : super(key: const Key('HomeAppBar'));

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
      bottom: const Tab(
        child: Text(
          'Your personal health companion',
          style: TextStyle(
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
