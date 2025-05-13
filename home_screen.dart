import 'package:flutter/material.dart';
import 'drug_list_screen.dart';
import 'reminder_screen.dart';
import 'symptom_checker_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drug Info App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DrugListScreen()),
                );
              },
              child: const Text('Drug Information'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReminderScreen()),
                );
              },
              child: const Text('Medication Reminders'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SymptomCheckerScreen()),
                );
              },
              child: const Text('Symptom Checker'),
            ),
          ],
        ),
      ),
    );
  }
}
