import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Services/Geolocator/geolocator.dart';
import '../../../../Core/Styles/text_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayLocationMap extends StatefulWidget {
  final PlaceModel placeModel;
  const DisplayLocationMap({required this.placeModel, super.key});

  @override
  State<DisplayLocationMap> createState() => _DisplayLocationMapState();
}

class _DisplayLocationMapState extends State<DisplayLocationMap> {
  late GoogleMapController mapController;
  String locationName = "";
  List<Marker> allMarkers = [];
  @override
  void initState() {
    addMarker();
    fillLocation();
    super.initState();
  }

  fillLocation() async {
    locationName = await GeoLocatorService.getAddressFromLatLng(
        widget.placeModel.placeLat, widget.placeModel.placeLong);
    setState(() {});
  }

  void onMapCreated(controller) {
    mapController = controller;
  }

  addMarker() {
    setState(() {
      allMarkers.add(Marker(
          markerId: const MarkerId('myMarker'),
          onTap: () {},
          position:
              LatLng(widget.placeModel.placeLat, widget.placeModel.placeLong)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Location",
            style: TextStyles.boldStyle.copyWith(fontFamily: 'Changa'),
          ),
          AutoSizeText(
            locationName,
            style: TextStyles.boldStyle
                .copyWith(fontSize: 13.sp, color: CustomColors.greyK),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 180.h,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.placeModel.placeLat, widget.placeModel.placeLong),
                  zoom: 16.0),
              onMapCreated: onMapCreated,
              markers: Set.from(allMarkers),
            ),
          )
        ],
      ),
    );
  }
}
