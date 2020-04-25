import 'package:geolocator/geolocator.dart';

class Location {
  Location({this.latitude, this.longitude});

  double latitude;
  double longitude;
  // Using Future and Async Functions to Get the User's Live Data.
  Future<void> locationdata() async {
    try {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    }
    catch (e) {
      print(e);
    }
  }

}