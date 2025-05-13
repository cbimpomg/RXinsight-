import 'package:hive/hive.dart';
part 'drug.g.dart';

@HiveType(typeId: 0)
class Drug extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String uses;
  @HiveField(3)
  String sideEffects;
  @HiveField(4)
  List<String> interactions;
  @HiveField(5)
  String dosageInfo;

  Drug({
    required this.id,
    required this.name,
    required this.uses,
    required this.sideEffects,
    required this.interactions,
    required this.dosageInfo,
  });

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      id: json['id'] as String,
      name: json['name'] as String,
      uses: json['uses'] as String,
      sideEffects: json['sideEffects'] as String,
      interactions: List<String>.from(json['interactions'] as List),
      dosageInfo: json['dosageInfo'] as String,
    );
  }
}
