part of 'devil_fruit_cubit.dart';

enum DevilFruitStatus { loading, loaded, error }


@freezed
class DevilFruitState with _$DevilFruitState {
  const DevilFruitState._();

  const factory DevilFruitState({
    @Default(DevilFruitStatus.loading) DevilFruitStatus status,
    @Default([]) List<DevilFruit> devilFruit,
    @Default('') String searchFilter,
    @Default('') String favSearchFilter,
    @Default('') String sortBy,
    @Default('') String favSortBy,
    @Default('') String typeFilter,
    @Default('') String favTypeFilter,
    @Default([]) List<DevilFruit> favourtieDevilFruitList,
    @Default(false) bool isEating,
    @Default(false) bool isConfetti,
    @Default(LatLng(0, 0)) LatLng newPosition,

  }) = _DevilFruitState;

  List<DevilFruit> get filteredAndSortedDevilFruitList {
    List<DevilFruit> filteredList = List<DevilFruit>.from(devilFruit);

    if (searchFilter.isNotEmpty) {
      filteredList = filteredList
          .where((element) => element.romanName
              .toLowerCase()
              .contains(searchFilter.toLowerCase()))
          .toList();
    }

    if (typeFilter != 'None' && typeFilter.isNotEmpty) {
      filteredList = filteredList
          .where((element) =>
              element.type.toLowerCase().contains(typeFilter.toLowerCase()))
          .toList();
    }

    if (sortBy == 'id') {
      filteredList.sort((a, b) => a.id.compareTo(b.id));
    } else if (sortBy == 'name') {
      filteredList.sort((a, b) =>
          a.romanName.toLowerCase().compareTo(b.romanName.toLowerCase()));
    }

    return filteredList;
  }

  List<DevilFruit> get filteredAndSortedFavourtieDevilFruitList {
    List<DevilFruit> favourtieDevilFruit =
        List<DevilFruit>.from(favourtieDevilFruitList);

    if (favSearchFilter.isNotEmpty) {
      favourtieDevilFruit = favourtieDevilFruit
          .where((element) => element.romanName
              .toLowerCase()
              .contains(favSearchFilter.toLowerCase()))
          .toList();
    }

    if (favTypeFilter != 'None' && favTypeFilter.isNotEmpty) {
      favourtieDevilFruit = favourtieDevilFruit
          .where((element) =>
              element.type.toLowerCase().contains(favTypeFilter.toLowerCase()))
          .toList();
    }

    if (favSortBy == 'id') {
      favourtieDevilFruit.sort((a, b) => a.id.compareTo(b.id));
    } else if (favSortBy == 'name') {
      favourtieDevilFruit.sort((a, b) =>
          a.romanName.toLowerCase().compareTo(b.romanName.toLowerCase()));
    }

    return favourtieDevilFruit;
  }
}
