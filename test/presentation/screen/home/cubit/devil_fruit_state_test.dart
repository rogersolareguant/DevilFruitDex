import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('DevilFruitStateTest', () {

    group('Creation', () {

      test('Can be created', () {
        const instance = DevilFruitState(
          status: DevilFruitStatus.loading,
          devilFruit: [],
          searchFilter: '',
          favSearchFilter: '',
          sortBy: '',
          favSortBy: '',
          typeFilter: '',
          favTypeFilter: '',
          favourtieDevilFruitList: [],
          isEating: false,
          newPosition: LatLng(0, 0)
        );

        expect(instance, isNotNull);
        expect(instance.status, DevilFruitStatus.loading);
        expect(instance.devilFruit, []);
        expect(instance.searchFilter, '');
        expect(instance.favSearchFilter, '');
        expect(instance.sortBy, '');
        expect(instance.favSortBy, '');
        expect(instance.typeFilter, '');
        expect(instance.favTypeFilter, '');
        expect(instance.favourtieDevilFruitList, []);
        expect(instance.isEating, false);
        expect(instance.newPosition, LatLng(0, 0));

      });
    });

    group('testing of the getter filteredAndSortedDevilFruitList', () {

      final devilFruitList = [const DevilFruit(
            id: 2, 
            romanName: 'Bara Bara no Mi', 
            filename: '', 
            name: '', 
            type: 'Paramecia', 
            description: '', 
            position: LatLng(0, 0)
          ),
          const DevilFruit(
            id: 1, 
            romanName: 'Gomu Gomu no Mi',
            filename: '',
            name: '',
            type: 'Paramecia',
            description: '', 
            position: LatLng(0, 0)
          ),  
          const DevilFruit(
            id: 3, 
            romanName: 'Goro Goro no Mi',
            filename: '',
            name: '',
            type: 'Logia',
            description: '', 
            position: LatLng(0, 0)
          ), 
        ];

      test('We do not use any filter for the Devil Fruit List', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          searchFilter: '',
          sortBy: ''
        );

        expect(state.filteredAndSortedDevilFruitList, devilFruitList);
      });

      test('Filter Devil Fruit List with the search bar', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          searchFilter: 'Go',
          sortBy: ''
        );

        expect(state.filteredAndSortedDevilFruitList, [devilFruitList[1], devilFruitList[2]]);
      });

      
      test('Sort Devil Fruit List by id', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          searchFilter: '',
          sortBy: 'id'
        );

        expect(state.filteredAndSortedDevilFruitList, [devilFruitList[1], devilFruitList[0], devilFruitList[2]]);
      });

      test('Sort Devil Fruit List by name', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          searchFilter: '',
          sortBy: 'name'
        );

        expect(state.filteredAndSortedDevilFruitList, [devilFruitList[0], devilFruitList[1], devilFruitList[2]]);
      });

      test('Aply both filters, search and sort', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          searchFilter: 'Go',
          sortBy: 'id'
        );

        expect(state.filteredAndSortedDevilFruitList, [devilFruitList[1], devilFruitList[2]]);
      });

      test('Filter Devil Fruit List by the type of the fruit', () {

        final state = DevilFruitState(
          devilFruit: devilFruitList,
          typeFilter: 'Logia'
        );

        expect(state.filteredAndSortedDevilFruitList, [devilFruitList[2]]);
      });
    });










    group('testing of the getter filteredAndSortedFavourtieDevilFruitList', () {

      final favourtieDevilFruitList = [const DevilFruit(
            id: 2, 
            romanName: 'Bara Bara no Mi', 
            filename: '', 
            name: '', 
            type: 'Paramecia', 
            description: '', 
            position: LatLng(0, 0)
          ),
          const DevilFruit(
            id: 1, 
            romanName: 'Gomu Gomu no Mi',
            filename: '',
            name: '',
            type: 'Paramecia',
            description: '', 
            position: LatLng(0, 0)
          ),  
          const DevilFruit(
            id: 3, 
            romanName: 'Goro Goro no Mi',
            filename: '',
            name: '',
            type: 'Logia',
            description: '', 
            position: LatLng(0, 0)
          ), 
        ];

      test('We do not use any favourite filter for the favourite Devil Fruit List', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favSearchFilter: '',
          favSortBy: ''
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, favourtieDevilFruitList);
      });

      test('Filter Favourite Devil Fruit List with the search bar', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favSearchFilter: 'Go',
          favSortBy: ''
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, [favourtieDevilFruitList[1], favourtieDevilFruitList[2]]);
      });

      
      test('Sort Favourite Devil Fruit List by id', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favSearchFilter: '',
          favSortBy: 'id'
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, [favourtieDevilFruitList[1], favourtieDevilFruitList[0], favourtieDevilFruitList[2]]);
      });

      test('Sort Favourite Devil Fruit List by name', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favSearchFilter: '',
          favSortBy: 'name'
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, [favourtieDevilFruitList[0], favourtieDevilFruitList[1], favourtieDevilFruitList[2]]);
      });

      test('Aply both filters, search and sort', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favSearchFilter: 'Go',
          favSortBy: 'id'
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, [favourtieDevilFruitList[1], favourtieDevilFruitList[2]]);
      });

      test('Filter Favourite Devil Fruit List by the type of the fruit', () {

        final state = DevilFruitState(
          favourtieDevilFruitList: favourtieDevilFruitList,
          favTypeFilter: 'Logia'
        );

        expect(state.filteredAndSortedFavourtieDevilFruitList, [favourtieDevilFruitList[2]]);
      });
    });
  });
}