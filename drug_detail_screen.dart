import 'package:flutter/material.dart';
import '../models/drug.dart';

class DrugDetailScreen extends StatelessWidget {
  final Drug drug;
  const DrugDetailScreen({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(drug.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Uses: ${drug.uses}'),
            const SizedBox(height: 8),
            Text('Side Effects: ${drug.sideEffects}'),
            const SizedBox(height: 8),
            Text('Interactions: ${drug.interactions.join(", ")}'),
            const SizedBox(height: 8),
            Text('Dosage Info: ${drug.dosageInfo}'),
          ],
        ),
      ),
    );
  }
}
