import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<Position?> getCurrentPosition() async {
    final status = await Permission.location.request();
    if (!status.isGranted) return null;

    if (!await Geolocator.isLocationServiceEnabled()) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
