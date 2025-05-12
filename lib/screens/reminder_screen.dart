import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../providers/medicine_provider.dart';
import '../models/reminder.dart';
import '../models/medicine.dart';
import 'package:intl/intl.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReminderProvider>(context, listen: false).loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<ReminderProvider>(
        builder: (context, provider, child) {
          final reminders = provider.reminders;
          if (reminders.isEmpty) {
            return const Center(
              child: Text('No reminders yet.', style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: const Icon(Icons.alarm, color: Colors.black),
                  title: Text(reminder.drugName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      'Time: ${TimeOfDay.fromDateTime(reminder.time).format(context)}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReminderScreen()),
          );
          if (result == true) {
            setState(() {}); // Refresh reminders
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  Medicine? _selectedMedicine;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final allMedicines = context.watch<MedicineProvider>().medicines;
    final medicines = allMedicines
        .where((m) => m.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
    final isLoading = allMedicines.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: Text(
                'No medicines available. Please add medicines first.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Search Medicine',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Type to search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onChanged: (val) => setState(() => _searchText = val),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Medicine>(
                    value: medicines.contains(_selectedMedicine)
                        ? _selectedMedicine
                        : null,
                    items: medicines.map((m) {
                      return DropdownMenuItem(
                        value: m,
                        child: Text(m.name),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedMedicine = val),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.black),
                          const SizedBox(width: 16),
                          Text(
                            _selectedDate != null
                                ? DateFormat('EEE, MMM d, yyyy')
                                    .format(_selectedDate!)
                                : 'Pick a date',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() => _selectedTime = picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.black),
                          const SizedBox(width: 16),
                          Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : 'Pick a time',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: (_selectedMedicine != null &&
                              _selectedTime != null &&
                              _selectedDate != null)
                          ? () {
                              final reminderTime = DateTime(
                                _selectedDate!.year,
                                _selectedDate!.month,
                                _selectedDate!.day,
                                _selectedTime!.hour,
                                _selectedTime!.minute,
                              );
                              final provider = context.read<ReminderProvider>();
                              provider.addReminder(Reminder(
                                id: UniqueKey().toString(),
                                drugId: _selectedMedicine!.id,
                                drugName: _selectedMedicine!.name,
                                dosage: _selectedMedicine!.dosage,
                                time: reminderTime,
                                frequency: 'Once',
                              ));
                              Navigator.pop(context, true);
                            }
                          : null,
                      child: const Text('Save Reminder',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
