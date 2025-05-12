import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/local_storage_service.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;

  final _localStorage = LocalStorageService();

  Future<void> loadReminders() async {
    _reminders = await _localStorage.getReminders();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await _localStorage.saveReminder(reminder);
    await loadReminders();
  }

  Future<void> deleteReminder(String id) async {
    await _localStorage.deleteReminder(id);
    await loadReminders();
  }
}
