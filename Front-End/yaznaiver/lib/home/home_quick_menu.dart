import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class HomeQuickMenu extends StatefulWidget {
  const HomeQuickMenu() : super(key: const Key('HomeQuickActions'));

  @override
  State<HomeQuickMenu> createState() => _HomeQuickMenuState();
}

class _HomeQuickMenuState extends State<HomeQuickMenu> {
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
        padding: const EdgeInsets.all(5),
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
            label.replaceAll(" ", "\n"),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
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
          Center(
            child: Text(
              AppLocalizations.of(context)!.quick_menu,
              style: const TextStyle(
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
                icon: Icons.folder,
                label: AppLocalizations.of(context)!.patients_profile,
                color: Colors.brown,
                nextRoute: '/medical-records',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureIcon(
                icon: Icons.water_drop,
                label: AppLocalizations.of(context)!.lab_results,
                color: Colors.red,
                nextRoute: '/lab-results',
              ),
              _buildFeatureIcon(
                icon: Icons.smart_toy,
                label: AppLocalizations.of(context)!.ai_assistant,
                color: Colors.green,
                nextRoute: '/ai-assistant',
              ),
              _buildFeatureIcon(
                icon: Icons.medication,
                label: AppLocalizations.of(context)!.medications,
                color: Colors.blue,
                nextRoute: '/drug-store',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureIcon(
                icon: Icons.image,
                label: AppLocalizations.of(context)!.xray_viewer,
                color: Colors.blue,
                nextRoute: '/x-ray-viewer',
              ),
              _buildFeatureIcon(
                icon: Icons.local_hospital,
                label: AppLocalizations.of(context)!.book_appointment,
                color: Colors.orange,
                nextRoute: '/appointment',
              ),
              _buildFeatureIcon(
                icon: Icons.sanitizer,
                label: AppLocalizations.of(context)!.vaccinations,
                color: Colors.blueGrey,
                nextRoute: '/vaccinations',
              ),
            ],
          )
        ],
      ),
    );
  }
}
