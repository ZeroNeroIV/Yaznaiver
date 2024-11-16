import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AppointmentContent extends StatefulWidget {
  const AppointmentContent() : super(key: const Key('AppointmentContent'));

  @override
  State<AppointmentContent> createState() => _AppointmentContentState();
}

class _AppointmentContentState extends State<AppointmentContent> {
  String? _selectedDomain;
  String? _selectedDoctor;
  String? _selectedTimeSlot;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final Map<String, List<String>> _domainDoctors = {
    'Cardiology': ['Dr. Smith', 'Dr. Johnson'],
    'Neurology': ['Dr. Williams', 'Dr. Brown'],
    'Pediatrics': ['Dr. Davis', 'Dr. Miller'],
  };

  final Map<String, List<String>> _doctorAvailability = {
    'Dr. Smith': ['9:00 AM', '11:00 AM', '2:00 PM'],
    'Dr. Johnson': ['10:00 AM', '1:00 PM', '3:00 PM'],
    'Dr. Williams': ['9:30 AM', '11:30 AM', '2:30 PM'],
    'Dr. Brown': ['10:30 AM', '1:30 PM', '3:30 PM'],
    'Dr. Davis': ['9:15 AM', '11:15 AM', '2:15 PM'],
    'Dr. Miller': ['10:45 AM', '1:45 PM', '3:45 PM'],
  };

  final List<Map<String, String>> _appointments = [];

  void _bookAppointment() {
    if (_selectedDomain == null ||
        _selectedDoctor == null ||
        _selectedTimeSlot == null ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.fill_fields_message)),
      );
      return;
    }

    setState(() {
      _appointments.add({
        'patient': _nameController.text,
        'domain': _selectedDomain!,
        'doctor': _selectedDoctor!,
        'time': _selectedTimeSlot!,
        'phone': _phoneController.text,
      });

      // Remove the booked time slot
      _doctorAvailability[_selectedDoctor]!.remove(_selectedTimeSlot);
    });

    _nameController.clear();
    _phoneController.clear();
    _selectedDomain = null;
    _selectedDoctor = null;
    _selectedTimeSlot = null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.book_appointment)),
    );
  }

  void _showAppointmentDetails(Map<String, String> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.book_appointment),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '${AppLocalizations.of(context)!.patient}: ${appointment['patient']}'),
              Text('Domain: ${appointment['domain']}'),
              Text(
                  '${AppLocalizations.of(context)!.doctor}: ${appointment['doctor']}'),
              Text(
                  '${AppLocalizations.of(context)!.time}: ${appointment['time']}'),
              Text(
                  '${AppLocalizations.of(context)!.phone_number}: ${appointment['phone']}'),
              const SizedBox(height: 10),
              Text(
                'Note: All the important information will be sent by SMS and add to the patient\'s account in the appointments section.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.book_appointment),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Medical Domain',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DropdownButtonFormField<String>(
            value: _selectedDomain,
            items: _domainDoctors.keys.map((String domain) {
              return DropdownMenuItem<String>(
                value: domain,
                child: Text(domain),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDomain = newValue;
                _selectedDoctor = null;
                _selectedTimeSlot = null;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedDomain != null) ...[
            Text(
              AppLocalizations.of(context)!.select_doctor,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            DropdownButtonFormField<String>(
              value: _selectedDoctor,
              items: _domainDoctors[_selectedDomain]!.map((String doctor) {
                return DropdownMenuItem<String>(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDoctor = newValue;
                  _selectedTimeSlot = null;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 20),
          if (_selectedDoctor != null) ...[
            Text(
              'Select Time Slot',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            DropdownButtonFormField<String>(
              value: _selectedTimeSlot,
              items:
                  _doctorAvailability[_selectedDoctor]!.map((String timeSlot) {
                return DropdownMenuItem<String>(
                  value: timeSlot,
                  child: Text(timeSlot),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTimeSlot = newValue;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.patient_details,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.full_name,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phone_number,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _bookAppointment,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(AppLocalizations.of(context)!.book_appointment),
          ),
          if (_appointments.isNotEmpty) ...[
            const SizedBox(height: 30),
            Text(
              'Booked Appointments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final appointment = _appointments[index];
                return Card(
                  child: ListTile(
                    title: Text(appointment['patient']!),
                    subtitle: Text(
                        '${appointment['doctor']} - ${appointment['time']}'),
                    onTap: () => _showAppointmentDetails(appointment),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
