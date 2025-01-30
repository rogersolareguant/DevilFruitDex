import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'devil_fruit_state.dart';
part 'devil_fruit_cubit.freezed.dart';

class DevilFruitCubit extends Cubit<DevilFruitState> {
  final DevilFruitRepository _repository;
  final FavouritesRepository _favRepository;
  final LocationRepository _locationRepository;
  final String uid;

  DevilFruitCubit(
      {required DevilFruitRepository repository,
      required FavouritesRepository favRepository,
      required LocationRepository locationRepository,
      required this.uid})
      : _repository = repository,
        _favRepository = favRepository,
        _locationRepository = locationRepository,
        super(const DevilFruitState()) {
    initialize();
  }

  late StreamSubscription<List<int>> _subscription;

  Future<void> initialize() async {
    await getAllDevilFruits();
    streamFavourteFruits();
    await deviceLocation();
  }

  Future<void> getAllDevilFruits() async {
    try {
      final devilFruit = await _repository.getAllDevilFruitsRepo();
      emit(state.copyWith(
        status: DevilFruitStatus.loaded,
        devilFruit: devilFruit,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DevilFruitStatus.error,
      ));
    }
  }

  Future<void> favouriteFruits(int fruitId) async {
    try {
      final currentFavFruit = await _favRepository.getFavourites(uid).first;

      List<int> updateFavourites = List.from(currentFavFruit);
      if (updateFavourites.contains(fruitId)) {
        updateFavourites.remove(fruitId);
      } else {
        updateFavourites.add(fruitId);
      }

      await _favRepository.setFavourites(uid, updateFavourites);
    } catch (e) {
      emit(state.copyWith(status: DevilFruitStatus.error));
    }
  }

  Future<void> deviceLocation() async {
    try {
      LatLng location = await _locationRepository.getPosition();
      emit(state.copyWith(
          status: DevilFruitStatus.loaded, newPosition: location));
    } catch (e) {
      emit(state.copyWith(status: DevilFruitStatus.error));
    }
  }

  void updateSearchFilter(String searchFilter) {
    emit(state.copyWith(
      status: DevilFruitStatus.loaded,
      searchFilter: searchFilter,
    ));
  }

  void updateFavSearchFilter(String favSearchFilter) {
    emit(state.copyWith(
      status: DevilFruitStatus.loaded,
      favSearchFilter: favSearchFilter,
    ));
  }

  void updateSortByFilter(String sortBy) {
    emit(state.copyWith(
      status: DevilFruitStatus.loaded,
      sortBy: sortBy,
    ));
  }

  void updateFavSortByFilter(String favSortBy) {
    emit(state.copyWith(
      status: DevilFruitStatus.loaded,
      favSortBy: favSortBy,
    ));
  }

  void updateTypeFilter(String typeFilter) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, 
        typeFilter: typeFilter));
  }

  void updateFavTypeFilter(String favTypeFilter) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, 
        favTypeFilter: favTypeFilter));
  }

  void updateNewPosition(LatLng newPosition) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, 
        newPosition: newPosition));
  }

  void updateEating(bool isEating) {
    emit(state.copyWith(status: DevilFruitStatus.loaded, 
    isEating: isEating));
  }

  void streamFavourteFruits() {
    _subscription =
        _favRepository.getFavourites(uid).listen((List<int> favoriteIDs) {
      final favourtieFruits = state.devilFruit
          .where((fruit) => favoriteIDs.contains(fruit.id))
          .toList();

      emit(state.copyWith(favourtieDevilFruitList: favourtieFruits));
    });
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
