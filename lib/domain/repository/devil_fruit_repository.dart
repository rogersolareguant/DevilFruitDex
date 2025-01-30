import 'package:devilfruitdex/domain/model/devil_fruit.dart';

abstract class DevilFruitRepository {
  Future<List<DevilFruit>> getAllDevilFruitsRepo();
}
