import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drug_provider.dart';
import 'drug_detail_screen.dart';

class DrugListScreen extends StatefulWidget {
  const DrugListScreen({super.key});

  @override
  State<DrugListScreen> createState() => _DrugListScreenState();
}

class _DrugListScreenState extends State<DrugListScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrugProvider>(context);
    final drugs =
        _search.isEmpty ? provider.drugs : provider.searchDrugs(_search);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drugs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await provider.fetchAndCacheDrugs();
              if (mounted) setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search drugs',
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
              onChanged: (val) => setState(() => _search = val),
            ),
          ),
          Expanded(
            child: drugs.isEmpty
                ? const Center(child: Text('No drugs found.'))
                : ListView.builder(
                    itemCount: drugs.length,
                    itemBuilder: (context, i) {
                      final drug = drugs[i];
                      return ListTile(
                        title: Text(drug.name),
                        subtitle: Text(drug.uses),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DrugDetailScreen(drug: drug),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
