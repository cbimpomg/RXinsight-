import 'package:hive/hive.dart';
part 'reminder.g.dart';

@HiveType(typeId: 1)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String drugId;
  @HiveField(2)
  String drugName;
  @HiveField(3)
  String dosage;
  @HiveField(4)
  DateTime time;
  @HiveField(5)
  String frequency;

  Reminder({
    required this.id,
    required this.drugId,
    required this.drugName,
    required this.dosage,
    required this.time,
    required this.frequency,
  });
}
