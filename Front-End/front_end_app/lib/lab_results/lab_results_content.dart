import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/lab_results/lab_test.dart';

class LabResultsContent extends StatefulWidget {
  const LabResultsContent() : super(key: const Key('LabResultsContent'));

  @override
  State<LabResultsContent> createState() => _LabResultsContentState();
}

class _LabResultsContentState extends State<LabResultsContent> {
  List<LabTest> _labTests = [];
  List<LabTest> _filteredTests = [];
  DateTime? _selectedDate;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _labTests = [
      LabTest(
        name: 'Complete Blood Count (CBC)',
        date: DateTime(2023, 5, 15),
        result: 'Normal',
        details: {
          'White Blood Cells': '7.5 x10^9/L',
          'Red Blood Cells': '5.0 x10^12/L',
          'Hemoglobin': '14.2 g/dL',
          'Hematocrit': '42%',
          'Platelets': '250 x10^9/L',
        },
        isNormal: true,
      ),
      LabTest(
        name: 'Lipid Panel',
        date: DateTime(2023, 5, 10),
        result: 'Abnormal',
        details: {
          'Total Cholesterol': '240 mg/dL',
          'LDL Cholesterol': '160 mg/dL',
          'HDL Cholesterol': '40 mg/dL',
          'Triglycerides': '200 mg/dL',
        },
        isNormal: false,
      ),
      LabTest(
        name: 'Thyroid Function Test',
        date: DateTime(2023, 4, 28),
        result: 'Normal',
        details: {
          'TSH': '2.5 mIU/L',
          'Free T4': '1.2 ng/dL',
          'Free T3': '3.1 pg/mL',
        },
        isNormal: true,
      ),
      LabTest(
        name: 'Liver Function Test',
        date: DateTime(2023, 4, 15),
        result: 'Normal',
        details: {
          'ALT': '25 U/L',
          'AST': '30 U/L',
          'ALP': '70 U/L',
          'Total Bilirubin': '0.8 mg/dL',
          'Albumin': '4.0 g/dL',
        },
        isNormal: true,
      ),
    ];
    _filteredTests = List.from(_labTests);
  }

  void _filterTests() {
    setState(() {
      _filteredTests = _labTests.where((test) {
        final nameMatch = test.name.toLowerCase().contains(_searchController.text.toLowerCase());
        final dateMatch = _selectedDate == null || test.date.isAtSameMomentAs(_selectedDate!);
        return nameMatch && dateMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.search_tests,
              suffixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) => _filterTests(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${AppLocalizations.of(context)!.filter_by_date}:'),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                    _filterTests();
                  });
                }
              },
              child: Text(_selectedDate == null ? AppLocalizations.of(context)!.select_date : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedDate = null;
                  _filterTests();
                });
              },
              child: Text(AppLocalizations.of(context)!.clear),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredTests.length,
            itemBuilder: (context, index) {
              final test = _filteredTests[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(test.name),
                  subtitle: Text(DateFormat('yyyy-MM-dd').format(test.date)),
                  trailing: Chip(
                    label: Text(
                      test.result,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: test.isNormal ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(test.name),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${AppLocalizations.of(context)!.date}: ${DateFormat('yyyy-MM-dd').format(test.date)}'),
                                Text('${AppLocalizations.of(context)!.result}: ${test.result}'),
                                const SizedBox(height: 16),
                                Text('${AppLocalizations.of(context)!.details}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ...test.details.entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 8),
                                    child: Text('${entry.key}: ${entry.value}'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
