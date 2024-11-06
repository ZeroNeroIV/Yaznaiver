import 'package:flutter/material.dart';

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Welcome, USER',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Sequel",
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'How can we assist you today?',
              style: TextStyle(
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
