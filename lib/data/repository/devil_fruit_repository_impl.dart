import 'dart:math';

import 'package:devilfruitdex/domain/exception/unable_get_all_devil_fruits_exception.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class DevilFruitRepositoryImpl extends DevilFruitRepository {
  final Dio dio;

  DevilFruitRepositoryImpl({required this.dio});

  @override
  Future<List<DevilFruit>> getAllDevilFruitsRepo() async {
    try {
      final valuesFruit = <DevilFruit>[];

      final response =
          await dio.get('https://api.api-onepiece.com/v2/fruits/en');

      for (final json in response.data) {
        DevilFruit fruit = DevilFruit.fromJson(json);

        final randomLat = Random().nextDouble() * 180 - 90;
        final randomLng = Random().nextDouble() * 360 - 180;
        fruit = fruit.copyWith(position: LatLng(randomLat, randomLng));

        valuesFruit.add(fruit);
      }
      return valuesFruit;
    } catch (e) {
      throw UnableGetAllDevilFruitsException(message: e.toString());
    }
  }
}
