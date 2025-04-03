import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        devilFruit: [],
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
      emit(state.copyWith(status: DevilFruitStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: DevilFruitStatus.error));
    }
  }

  Future<LatLng> deviceLocation() async {
    try {
      LatLng location = await _locationRepository.getPosition();
      emit(state.copyWith(
          status: DevilFruitStatus.loaded, newPosition: location));
      return location;
    } catch (e) {
      emit(state.copyWith(
          status: DevilFruitStatus.error, newPosition: state.newPosition));
      return state.newPosition;
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
        status: DevilFruitStatus.loaded, typeFilter: typeFilter));
  }

  void updateFavTypeFilter(String favTypeFilter) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, favTypeFilter: favTypeFilter));
  }

  void updateNewPosition(LatLng newPosition) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, newPosition: newPosition));
  }

  void updateEating(bool isEating) {
    emit(state.copyWith(
        status: DevilFruitStatus.loaded, isEating: isEating, isConfetti: true));

    Future.delayed(const Duration(seconds: 3), () {
      emit(state.copyWith(isConfetti: false));
    });
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

  void signOut() {
    FirebaseAuth.instance.signOut();
    emit(state.copyWith(
      status: DevilFruitStatus.loading,
    ));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
