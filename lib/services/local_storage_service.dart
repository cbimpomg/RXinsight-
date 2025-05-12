import 'package:hive/hive.dart';
import '../models/drug.dart';
import '../models/reminder.dart';
import '../models/medicine.dart';

class LocalStorageService {
  static const String drugBoxName = 'drugs';
  static const String reminderBoxName = 'reminders';
  static const String medicineBoxName = 'medicines';

  Future<void> saveDrugs(List<Drug> drugs) async {
    final box = await Hive.openBox<Drug>(drugBoxName);
    await box.clear();
    for (var drug in drugs) {
      await box.put(drug.id, drug);
    }
  }

  Future<List<Drug>> getDrugs() async {
    final box = await Hive.openBox<Drug>(drugBoxName);
    return box.values.toList();
  }

  Future<void> saveReminder(Reminder reminder) async {
    final box = await Hive.openBox<Reminder>(reminderBoxName);
    await box.put(reminder.id, reminder);
  }

  Future<List<Reminder>> getReminders() async {
    final box = await Hive.openBox<Reminder>(reminderBoxName);
    return box.values.toList();
  }

  Future<void> deleteReminder(String id) async {
    final box = await Hive.openBox<Reminder>(reminderBoxName);
    await box.delete(id);
  }

  Future<void> saveMedicines(List<Medicine> medicines) async {
    final box = await Hive.openBox<Medicine>(medicineBoxName);
    await box.clear();
    for (var medicine in medicines) {
      await box.put(medicine.id, medicine);
    }
  }

  Future<List<Medicine>> getMedicines() async {
    final box = await Hive.openBox<Medicine>(medicineBoxName);
    return box.values.toList();
  }

  Future<void> deleteMedicine(String id) async {
    final box = await Hive.openBox<Medicine>(medicineBoxName);
    await box.delete(id);
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(drugBoxName);
    await Hive.deleteBoxFromDisk(reminderBoxName);
    await Hive.deleteBoxFromDisk(medicineBoxName);
  }
}
