import 'package:flutter/material.dart';

class HomeQuickActions extends StatefulWidget {
  const HomeQuickActions() : super(key: const Key('HomeQuickActions'));

  @override
  State<HomeQuickActions> createState() => _HomeQuickActionsState();
}

class _HomeQuickActionsState extends State<HomeQuickActions> {
  Map<String, bool> hoverStates = {};

  Widget _buildFeatureIcon({
    required IconData icon,
    required String label,
    required Color color,
    required String nextRoute,
  }) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(0),
      ),
      onHover: (isHovering) {
        setState(() {
          hoverStates[label] = isHovering;
        });
      },
      onPressed: () {
        Navigator.pushNamed(context, nextRoute);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: hoverStates[label] == true ? color.withOpacity(0.5) : color.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(
            child: Text(
              'Quick Action Menu',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Sequel',
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureIcon(
                icon: Icons.smart_toy,
                label: 'AI Assistant',
                color: Colors.green,
                nextRoute: '/ai-assistant',
              ),
              _buildFeatureIcon(
                icon: Icons.folder,
                label: 'Medical\nRecords',
                color: Colors.brown,
                nextRoute: '/medical-records',
              ),
              _buildFeatureIcon(
                icon: Icons.sanitizer,
                label: 'Vaccinations',
                color: Colors.blueGrey,
                nextRoute: '/vaccinations',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureIcon(
                icon: Icons.local_hospital,
                label: 'Book\nAppointment',
                color: Colors.orange,
                nextRoute: '/appointment',
              ),
              _buildFeatureIcon(
                icon: Icons.water_drop,
                label: 'View\nLab Results',
                color: Colors.red,
                nextRoute: '/lab-results',
              ),
              _buildFeatureIcon(
                icon: Icons.medication,
                label: 'View\nDrugs',
                color: Colors.blue,
                nextRoute: '/drug-store',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
