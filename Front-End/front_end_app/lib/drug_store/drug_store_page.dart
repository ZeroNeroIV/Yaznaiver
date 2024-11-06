import 'package:flutter/material.dart';

import 'drug_store_content.dart';

class DrugStorePage extends StatelessWidget {
  const DrugStorePage() : super(key: const Key('DrugStorePage'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug Store'),
        centerTitle: true,
      ),
      body: const DrugStoreContent(),
    );
  }
}
