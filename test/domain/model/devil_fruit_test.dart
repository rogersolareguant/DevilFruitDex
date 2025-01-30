import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group(
    'DevilFruit',
    () {
      group(
        'Creation',
        () {
          test(
            'Can be created',
            () {
              const instance = DevilFruit(
                  id: 1,
                  romanName: '',
                  filename: '',
                  name: '',
                  type: '',
                  description: '',
                  position: LatLng(0, 0));

              expect(instance, isNotNull);
              expect(instance.id, 1);
              expect(instance.romanName, '');
              expect(instance.filename, '');
              expect(instance.name, '');
              expect(instance.type, '');
              expect(instance.description, '');
              expect(instance.position, LatLng(0, 0));
            },
          );

          test(
            '.fromJson return a correct instance',
            () {
              final instance = DevilFruit.fromJson(const <String, dynamic>{
                'id': 1,
                'roman_name': 'Gomu Gomu no Mi',
                'filename':
                    'https://images.api-onepiece.com/fruits/5665e89442022d4c0e7684c650dc6d6b.png',
                'name': 'Gum-Gum Fruit',
                'type': 'Paramecia',
                'description':
                    "Gomu Gomu no Mi, also known as the Fruit of Gum-Gum in French, is a Paramecia-type Demon Fruit that imparts the same properties as rubber to its user's body, making the eater an Elastic Man (ゴム人間, Gomu Ningen). This was once a treasure that Shanks and his crew had taken from a World Government convoy, protected by CP9, but which was accidentally eaten by Monkey D. Luffy",
              });

              expect(instance, isNotNull);
              expect(instance.id, 1);
              expect(instance.romanName, 'Gomu Gomu no Mi');
              expect(instance.filename,
                  'https://images.api-onepiece.com/fruits/5665e89442022d4c0e7684c650dc6d6b.png');
              expect(instance.name, 'Gum-Gum Fruit');
              expect(instance.type, 'Paramecia');
              expect(instance.description,
                  "Gomu Gomu no Mi, also known as the Fruit of Gum-Gum in French, is a Paramecia-type Demon Fruit that imparts the same properties as rubber to its user's body, making the eater an Elastic Man (ゴム人間, Gomu Ningen). This was once a treasure that Shanks and his crew had taken from a World Government convoy, protected by CP9, but which was accidentally eaten by Monkey D. Luffy");
            },
          );
        },
      );
    },
  );
}
