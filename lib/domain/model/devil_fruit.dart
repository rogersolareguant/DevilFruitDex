import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'devil_fruit.freezed.dart';

@freezed
class DevilFruit with _$DevilFruit {
  const factory DevilFruit({
    required int id,
    required String romanName,
    required String filename,
    required String name,
    required String type,
    required String description,
    required LatLng position,
  }) = _DevilFruit;

  factory DevilFruit.fromJson(Map<String, dynamic> json) {
    return DevilFruit(
      id: json['id'],
      romanName: json['roman_name'] ?? json['name'],
      filename: json['filename'],
      name: json['name'],
      type: json['type'],
      description: json['description'], 
      position: LatLng(0, 0)
    );
  }
}
