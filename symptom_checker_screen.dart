import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drug_provider.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  String _symptom = '';
  List<String> _results = [];

  void _search(BuildContext context) {
    final provider = Provider.of<DrugProvider>(context, listen: false);
    final drugs = provider.drugs
        .where((d) =>
            d.uses.toLowerCase().contains(_symptom.toLowerCase()) ||
            d.sideEffects.toLowerCase().contains(_symptom.toLowerCase()))
        .map((d) => d.name)
        .toList();
    setState(() => _results = drugs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter symptom',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF9C27B0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF9C27B0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      const BorderSide(color: Color(0xFF9C27B0), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                hintStyle: const TextStyle(color: Colors.black54),
              ),
              onChanged: (val) => _symptom = val,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _search(context),
              child: const Text('Check'),
            ),
            const SizedBox(height: 24),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView(
                  children: _results
                      .map((name) => ListTile(title: Text(name)))
                      .toList(),
                ),
              )
            else if (_symptom.isNotEmpty)
              const Text('No matching drugs found.'),
          ],
        ),
      ),
    );
  }
}
