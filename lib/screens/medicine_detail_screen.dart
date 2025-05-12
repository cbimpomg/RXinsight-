import 'package:flutter/material.dart';
import '../models/medicine.dart';

class MedicineDetailScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine Image/Icon
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.medication_outlined,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Category
            _buildInfoSection('Category', medicine.category),

            // Description
            _buildInfoSection('Description', medicine.description),

            // Dosage
            _buildInfoSection('Dosage', medicine.dosage),

            // Side Effects
            _buildInfoSection(
              'Side Effects',
              medicine.sideEffects.join('\n• '),
              prefix: '• ',
            ),

            // Interactions
            _buildInfoSection(
              'Drug Interactions',
              medicine.interactions.join('\n• '),
              prefix: '• ',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, {String prefix = ''}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            prefix + content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
