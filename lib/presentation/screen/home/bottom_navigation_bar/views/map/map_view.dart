import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                          initialCenter: state.newPosition,
                          initialZoom: 4,
                          interactionOptions:
                              InteractionOptions(flags: InteractiveFlag.drag),
                          onTap: (tapPosition, point) {
                            context
                                .read<DevilFruitCubit>()
                                .updateNewPosition(point);
                            _mapController.move(point, 4);
                          }),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
                        ),
                        AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return CircleLayer(circles: [
                                CircleMarker(
                                    point: state.newPosition,
                                    color: Colors.blue.withOpacity(0.3),
                                    radius: 50),
                                ...state.devilFruit.map((fruit) => CircleMarker(
                                    point: fruit.position,
                                    color: fruit.type == 'Paramecia'
                                        ? colors.error.withOpacity(0.3)
                                        : fruit.type == 'Logia'
                                            ? colors.primary.withOpacity(0.3)
                                            : fruit.type == 'Zoan' ||
                                                    fruit.type ==
                                                        'Zoan Antique' ||
                                                    fruit.type ==
                                                        'Zoan Mythique'
                                                ? colors.secondary
                                                    .withOpacity(0.3)
                                                : colors.tertiary
                                                    .withOpacity(0.3),
                                    radius: 25 + (_pulseAnimation.value * 10)))
                              ]);
                            }),
                        MarkerLayer(markers: [
                          Marker(
                            point: state.newPosition,
                            child: Icon(
                              Icons.location_on,
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                                          'assets/images/incognit-fruit.png'),
                                ));
                          }),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final newPosition =
                  await context.read<DevilFruitCubit>().deviceLocation();
              _mapController.move(newPosition, 4);
            },
            backgroundColor: Theme.of(context).cardColor,
            child: Icon(Icons.my_location, color: Theme.of(context).focusColor),
          ),
        );
      },
    );
  }
}
