import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicineDetailsPage extends StatelessWidget {
  final String medicine;

  const MedicineDetailsPage({super.key, required this.medicine});

  // To handle setting up notifications (for the alarm)
  Future<void> _setAlarm(BuildContext context) async {
    // You can use a package like flutter_local_notifications for real alarm functionality
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Example of setting an alarm (You'd need to set up flutter_local_notifications first)
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm Notifications',
      channelDescription: 'Channel for medicine alarms',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Medicine Alarm',
      'Time to take your $medicine!',
      notificationDetails,
      payload: 'medicine_alarm',
    );

    // Show a dialog after setting the alarm
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alarm Set'),
        content: Text('Alarm has been set for $medicine at the specified time.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.go),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the purchase page or open an URL
              // Example: Open a website or show a dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.buy_medicine),
                  content: Text('Redirecting to buy $medicine.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Here you could navigate to a purchase page or open a link
                      },
                      child: Text(AppLocalizations.of(context)!.go),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.alarm),
            onPressed: () {
              _setAlarm(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.medicines}: $medicine', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Alarm: Set to 8:00 AM every day', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context)!.quantity}: 30 ${AppLocalizations.of(context)!.tablets}', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
