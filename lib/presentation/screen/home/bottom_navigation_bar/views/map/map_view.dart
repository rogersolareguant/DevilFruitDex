import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {

  MapView({super.key});

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevilFruitCubit, DevilFruitState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        initialCenter: state.newPosition,
                        initialZoom: 4,
                        onTap: (tapPosition, point) {
                          context
                              .read<DevilFruitCubit>()
                              .updateNewPosition(point);
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
                      ),
                      CircleLayer(circles: [
                        CircleMarker(
                            point: state.newPosition,
                            color: Colors.blue.withOpacity(0.3),
                            radius: 50)
                      ]),
                      MarkerLayer(markers: [
                        Marker(
                
                          point: state.newPosition,
                          child: Icon(
                            Icons.location_on,
                          ),
                        ),
                        ...state.devilFruit.map((fruit) {
                          return Marker(
                              point: fruit.position,
                              width: 35,
                              height: 35,
                              child: GestureDetector(
                                onTap: () {
                                  double distance = Distance().as(
                                      LengthUnit.Meter,
                                      state.newPosition,
                                      fruit.position);

                                  //in 277903 out 380036
                                  if (distance <= 380000) {
                                    context.go('/home/eat/${fruit.id}');
                                  } else {
                                    context.go('/home/detail/${fruit.id}');
                                  }
                                },
                                child: fruit.filename.contains('.png') ||
                                        fruit.filename.contains('.jpg')
                                    ? Image.network(fruit.filename)
                                    : Image.asset(
                                        '/Users/rogersolareguant/Desktop/Flutter/devil_fruitdex/assets/images/incognit-fruit.png'),
                              ));
                        }),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              context.read<DevilFruitCubit>().deviceLocation();
            },
            backgroundColor: Theme.of(context).cardColor,
            child: Icon(Icons.my_location, color: Theme.of(context).focusColor),
          ),
        );
      },
    );
  }
}



