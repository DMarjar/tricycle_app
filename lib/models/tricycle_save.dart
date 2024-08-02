import 'package:equatable/equatable.dart';

class TricycleSave extends Equatable {
  final String brand;
  final String model;
  final String material;
  final int load_capacity;

  const TricycleSave({
    required this.brand,
    required this.model,
    required this.material,
    required this.load_capacity,
  });

  @override
  List<Object?> get props => [brand, model, material, load_capacity];

  factory TricycleSave.fromJson(Map<String, dynamic> json) {
    return TricycleSave(
      brand: json['brand'] as String,
      model: json['model'] as String,
      material: json['material'] as String,
      load_capacity: json['load_capacity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'model': model,
      'material': material,
      'load_capacity': load_capacity,
    };
  }

  TricycleSave copyWith({
    String? brand,
    String? model,
    String? material,
    int? load_capacity,
  }) {
    return TricycleSave(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      material: material ?? this.material,
      load_capacity: load_capacity ?? this.load_capacity,
    );
  }
}
