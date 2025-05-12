// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../models/drug.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class DrugProvider extends ChangeNotifier {
  List<Drug> _drugs = [];
  List<Drug> get drugs => _drugs;

  final _apiService = ApiService();
  final _localStorage = LocalStorageService();

  Future<void> loadDrugs() async {
    _drugs = await _localStorage.getDrugs();
    notifyListeners();
  }

  Future<void> fetchAndCacheDrugs() async {
    _drugs = await _apiService.fetchDrugs();
    await _localStorage.saveDrugs(_drugs);
    notifyListeners();
  }

  List<Drug> searchDrugs(String query) {
    return _drugs
        .where((d) => d.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
