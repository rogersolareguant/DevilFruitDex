
import 'package:latlong2/latlong.dart';

abstract class LocationRepository {

  Future<LatLng> getPosition();
}
