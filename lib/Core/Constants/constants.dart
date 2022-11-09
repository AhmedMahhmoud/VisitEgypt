import 'package:flutter/material.dart';

import '../../Features/Home/Model/place_model.dart';

class Constants {
  static const List<PlaceModel> allPlaces = [
    PlaceModel(
        placeId: 1,
        placeName: 'Abo El Hol',
        cityOfPlace: 'Giza',
        placeDescription:
            'Sphinx - Abu al-Hol. The leonine Sphinx, known as Abu al-Hol (Father Of Terror) to the Arabs, has been guarding the Giza Plateau for about 4500 years. Located at the approach to the Khafre Pyramid & facing the sunrise, this statue is about 66 ft high & is the largest monolithic statue in the world.',
        placeImage: 'assets/images/aboelhol.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 2,
        placeName: 'Abu Simbel Temple',
        cityOfPlace: 'Aswan',
        placeDescription:
            'Abu Simbel is a historic site comprising two massive rock-cut temples in the village of Abu Simbel',
        placeImage: 'assets/images/abosimple.jpg',
        placeRate: 7),
    PlaceModel(
        placeId: 3,
        placeName: 'Cairo Tower',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Cairo Tower is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it is the tallest structure in Egypt and North Africa.',
        placeImage: 'assets/images/cairotower.jpg',
        placeRate: 7.5),
    PlaceModel(
        placeId: 4,
        placeName: 'mohamed ali mosque',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Great Mosque of Muhammad Ali Pasha or Alabaster Mosque is a mosque situated in the Citadel of Cairo in Egypt and was commissioned by Muhammad Ali Pasha .',
        placeImage: 'assets/images/mohamedali.jpg',
        placeRate: 9),
    PlaceModel(
        placeId: 5,
        placeName: 'The Egyptian Museum',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Egyptian Museum is the oldest archaeological museum in the Middle East, and houses the largest collection of Pharaonic antiquities in the world.',
        placeImage: 'assets/images/museum.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 6,
        placeName: 'Giza pyramid',
        cityOfPlace: 'Giza',
        placeDescription:
            'The Great Pyramid and the Pyramid of Khafre are the largest pyramids built in ancient Egypt, and they have historically been common as emblems of Ancient Egypt ...',
        placeImage: 'assets/images/pyramids.jpg',
        placeRate: 9),
    PlaceModel(
        placeId: 7,
        placeName: 'Philae Temple',
        cityOfPlace: 'Aswan',
        placeDescription:
            'The sacred Temple of Isis (more commonly known as Philae Temple) is one of Upper Egypt\'s most beguiling monuments both for the exquisite artistry of its reliefs and for the gorgeous symmetry of its architecture, which made it a favorite subject of Victorian painters.',
        placeImage: 'assets/images/PhilaeTemple.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 8,
        placeName: 'Nubian Museum',
        cityOfPlace: 'Aswan',
        placeDescription:
            'Aswan\'s rather fantastic Nubian Museum is one of Egypt\'s best and a must for anyone interested in the history and culture of both ancient and modern Nubia.',
        placeImage: 'assets/images/NubianMuseum.jpg',
        placeRate: 6),
  ];

  static const SizedBox heightSpace = SizedBox(
    height: 5,
  );
  static const SizedBox widthSpace = SizedBox(
    width: 5,
  );

  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12, // Black color with 12% opacity
  );
}
