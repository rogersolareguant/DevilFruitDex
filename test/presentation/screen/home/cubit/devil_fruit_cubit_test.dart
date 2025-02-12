import 'package:bloc_test/bloc_test.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'devil_fruit_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DevilFruitRepository>(),
  MockSpec<FavouritesRepository>(),
  MockSpec<LocationRepository>(),
])
void main() {
  late DevilFruitCubit cubit;
  late MockDevilFruitRepository mockDevilFruitRepository;
  late MockFavouritesRepository mockFavouritesRepository;
  late MockLocationRepository mockLocationRepository;
  const String uid = '';

  const devilFruit = DevilFruit(
      id: 1,
      romanName: '',
      filename: '',
      name: '',
      type: '',
      description: '',
      position: LatLng(0, 0));

  const String searchFilter = 'Bara Bara no Mi';
  const String favSearchFilter = 'Gomu Gomu no Mi';
  const String sortBy = 'id';
  const String favSortBy = 'name';
  const String typeFilter = 'Paramecia';
  const String favTypeFilter = 'Logia';

  const LatLng testLocation = LatLng(41, 1);

  setUp(() {
    mockDevilFruitRepository = MockDevilFruitRepository();
    mockFavouritesRepository = MockFavouritesRepository();
    mockLocationRepository = MockLocationRepository();

    cubit = DevilFruitCubit(
      repository: mockDevilFruitRepository,
      favRepository: mockFavouritesRepository,
      locationRepository: mockLocationRepository,
      uid: uid,
    );
  });

  group('DevilFruitCubitTest', () {
    group('Creation', () {
      test('can be created', () {
        final instance = DevilFruitCubit(
            repository: MockDevilFruitRepository(),
            favRepository: MockFavouritesRepository(),
            locationRepository: MockLocationRepository(),
            uid: '');

        expect(instance.state, const DevilFruitState());
      });
    });

    group('getAllDevilFruits', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
          'emit [DevilFruitStatus.loaded] when response is success',
          build: () => cubit,
          setUp: () {
            when(mockDevilFruitRepository.getAllDevilFruitsRepo())
                .thenAnswer((_) => Future.value([devilFruit]));
          },
          act: (cubit) => cubit.getAllDevilFruits(),
          expect: () => <DevilFruitState>[
                const DevilFruitState(
                  status: DevilFruitStatus.loaded,
                  devilFruit: [devilFruit],
                )
              ]);
    });

    group('favouriteFruits', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
          'calls setFavourites when updating favourites',
          build: () => cubit,
          setUp: () {
            when(mockFavouritesRepository.getFavourites(uid))
                .thenAnswer((_) => Stream.value([1, 2]));
            when(mockFavouritesRepository.setFavourites(uid, [3]))
                .thenAnswer((_) => Future.value());
          },
          act: (cubit) => cubit.favouriteFruits(3),
          expect: () => <DevilFruitState>[
                const DevilFruitState(
                  status: DevilFruitStatus.loaded,
                )
              ]);
    });

    group('deviceLocation', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [location] when updates location correctly when deviceLocation is called',
        build: () => cubit,
        setUp: () {
          when(mockLocationRepository.getPosition())
              .thenAnswer((_) => Future.value(testLocation));
        },
        act: (cubit) => cubit.deviceLocation(),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, newPosition: testLocation),
        ],
      );
    });

    group('updateSearchFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update search filter',
        build: () => cubit,
        act: (cubit) => cubit.updateSearchFilter(searchFilter),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, searchFilter: searchFilter),
        ],
      );
    });

    group('updateFavSearchFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update favourite search filter',
        build: () => cubit,
        act: (cubit) => cubit.updateFavSearchFilter(favSearchFilter),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded,
              favSearchFilter: favSearchFilter),
        ],
      );
    });

    group('updateSortByFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update sortBy filter',
        build: () => cubit,
        act: (cubit) => cubit.updateSortByFilter(sortBy),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, sortBy: sortBy),
        ],
      );
    });

    group('updateFavSortByFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update favourite sortBy filter',
        build: () => cubit,
        act: (cubit) => cubit.updateFavSortByFilter(favSortBy),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, favSortBy: favSortBy),
        ],
      );
    });

    group('updateTypeFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update type filter',
        build: () => cubit,
        act: (cubit) => cubit.updateTypeFilter(typeFilter),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, typeFilter: typeFilter),
        ],
      );
    });

    group('updateFavTypeFilter', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update favourite type filter',
        build: () => cubit,
        act: (cubit) => cubit.updateFavTypeFilter(favTypeFilter),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, favTypeFilter: favTypeFilter),
        ],
      );
    });

    group('updateNewPosition', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update the position of the marker',
        build: () => cubit,
        act: (cubit) => cubit.updateNewPosition(LatLng(1, 103)),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, newPosition: LatLng(1, 103)),
        ],
      );
    });

    group('updateEating', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'emit [state.status] when we update the eating of the fruit',
        build: () => cubit,
        act: (cubit) => cubit.updateEating(true),
        expect: () => <DevilFruitState>[
          const DevilFruitState(
              status: DevilFruitStatus.loaded, isEating: true),
        ],
      );
    });

    group('close Stream', () {
      blocTest<DevilFruitCubit, DevilFruitState>(
        'closes the stream subscription on close()',
        build: () => cubit,
        act: (cubit) => cubit.close(),
      );
    });
  });
}
