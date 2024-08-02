import 'package:equatable/equatable.dart';

class Tricycle extends Equatable {
  final int id;
  final String brand;
  final String model;
  final String material;
  final int load_capacity;

  const Tricycle({
    required this.id,
    required this.brand,
    required this.model,
    required this.material,
    required this.load_capacity,
  });

  @override
  List<Object?> get props => [id, brand, model, material, load_capacity];

  factory Tricycle.fromJson(Map<String, dynamic> json) {
    return Tricycle(
      id: json['id'] as int,
      brand: json['brand'] as String,
      model: json['model'] as String,
      material: json['material'] as String,
      load_capacity: json['load_capacity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'material': material,
      'load_capacity': load_capacity,
    };
  }

  Tricycle copyWith({
    int? id,
    String? brand,
    String? model,
    String? material,
    int? load_capacity,
  }) {
    return Tricycle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      material: material ?? this.material,
      load_capacity: load_capacity ?? this.load_capacity,
    );
  }
}
