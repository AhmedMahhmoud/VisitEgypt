import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';



class GeoLocatorService {
  static Future<Position> getCurrentUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ('Location services are disabled.');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw ('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }


  static Future<String> getCurrentAddress()async{
    List<Placemark>placeMark=await placemarkFromCoordinates(Prefs.getDouble('UserLat')!,Prefs.getDouble('UserLng')!);
      print('name ${placeMark[0].name}');
      print('administrativeArea ${placeMark[0].administrativeArea}');
      print('country ${placeMark[0].country}');
      print('locality ${placeMark[0].locality}');
      print('street ${placeMark[0].street}');
      print('subLocality ${placeMark[0].subLocality}');
    return placeMark[0].administrativeArea.toString();
  }




}
