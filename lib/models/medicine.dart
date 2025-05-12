import 'package:hive/hive.dart';

part 'medicine.g.dart';

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String dosage;

  @HiveField(4)
  final List<String> sideEffects;

  @HiveField(5)
  final List<String> interactions;

  @HiveField(6)
  final String category;

  @HiveField(7)
  final String imageUrl;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.dosage,
    required this.sideEffects,
    required this.interactions,
    required this.category,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dosage': dosage,
      'sideEffects': sideEffects,
      'interactions': interactions,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      dosage: json['dosage'] as String,
      sideEffects: List<String>.from(json['sideEffects'] as List),
      interactions: List<String>.from(json['interactions'] as List),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
