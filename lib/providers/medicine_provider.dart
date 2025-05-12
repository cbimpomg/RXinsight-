import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/medicine_database_service.dart';

class MedicineProvider extends ChangeNotifier {
  final MedicineDatabaseService _databaseService = MedicineDatabaseService();
  List<Medicine> _medicines = [];
  bool _isLoading = false;
  String? _error;

  List<Medicine> get medicines => _medicines;
  bool get isLoading => _isLoading;
  String? get error => _error;

  MedicineProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _databaseService.initialize();
    await searchMedicines(''); // Load all medicines on initialization
  }

  Future<void> searchMedicines(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _databaseService.searchMedicines(query);
      _medicines = results;
    } catch (e) {
      print('Error searching medicines: $e');
      _medicines = [];
      _error = 'Failed to search medicines. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    searchMedicines('');
  }
}
