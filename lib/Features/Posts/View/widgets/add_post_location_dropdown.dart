import 'package:flutter/material.dart';
import 'package:task/Core/Constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostLocationDropdown extends StatefulWidget {
  final Function onDone;
  const AddPostLocationDropdown({required this.onDone, super.key});

  @override
  State<AddPostLocationDropdown> createState() =>
      _AddPostLocationDropdownState();
}

class _AddPostLocationDropdownState extends State<AddPostLocationDropdown> {
  List<String> locations = Constants.allPlaces.map((e) => e.placeName).toList();
  String selectedLocation = "";
  updateLocations(String newLocation) {
    selectedLocation = newLocation;
    widget.onDone(newLocation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 25.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: const Text(" Location"),
          onChanged: (value) => updateLocations(value.toString()),
          items: locations
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          elevation: 2,
          isExpanded: true,
          value: selectedLocation == "" ? null : selectedLocation,
        ),
      ),
    );
  }
}
