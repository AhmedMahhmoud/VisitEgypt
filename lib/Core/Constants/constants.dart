import 'package:flutter/material.dart';

import '../../Features/Home/Model/place_model.dart';

class Constants {
  static const List<PlaceModel> allPlaces = [
    PlaceModel(
        placeId: 1,
        placeImagesList: [
          'assets/images/aboelhol.jpg',
          'assets/images/aboelhol1.jpg',
          'assets/images/aboelhol2.jpg',
          'assets/images/aboelhol3.jpeg'
        ],
        placeName: 'Abo El Hol',
        cityOfPlace: 'Giza',
        placeDescription:
            'Sphinx - Abu al-Hol. The leonine Sphinx, known as Abu al-Hol (Father Of Terror) to the Arabs, has been guarding the Giza Plateau for about 4500 years. Located at the approach to the Khafre Pyramid & facing the sunrise, this statue is about 66 ft high & is the largest monolithic statue in the world.',
        placeImage: 'assets/images/aboelhol.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 2,
        placeImagesList: [
          'assets/images/abosimple.jpg',
          'assets/images/abosimple1.jpg',
          'assets/images/abosimple2.jpeg',
          'assets/images/abosimple3.jpg'
        ],
        placeName: 'Abu Simbel Temple',
        cityOfPlace: 'Aswan',
        placeDescription:
            'Abu Simbel is a historic site comprising two massive rock-cut temples in the village of Abu Simbel',
        placeImage: 'assets/images/abosimple.jpg',
        placeRate: 7),
    PlaceModel(
        placeId: 3,
        placeImagesList: [
          'assets/images/cairotower.jpg',
          'assets/images/cairotower1.jpg',
          'assets/images/cairotower2.jpg',
          'assets/images/cairotower3.jpg',
          'assets/images/cairotower4.jpg',
        ],
        placeName: 'Cairo Tower',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Cairo Tower is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it is the tallest structure in Egypt and North Africa.',
        placeImage: 'assets/images/cairotower.jpg',
        placeRate: 7.5),
    PlaceModel(
        placeId: 4,
        placeImagesList: [
          'assets/images/mohamedali.jpg',
          'assets/images/mohamedali1.jpg',
          'assets/images/mohamedali2.jpg',
          'assets/images/mohamedali3.jpg',
          'assets/images/mohamedali4.jpg',
        ],
        placeName: 'mohamed ali mosque',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Great Mosque of Muhammad Ali Pasha or Alabaster Mosque is a mosque situated in the Citadel of Cairo in Egypt and was commissioned by Muhammad Ali Pasha .',
        placeImage: 'assets/images/mohamedali.jpg',
        placeRate: 9),
    PlaceModel(
        placeId: 5,
        placeImagesList: [
          'assets/images/museum.jpg',
          'assets/images/museum1.jpg',
          'assets/images/museum2.jpg',
          'assets/images/museum3.jpg',
          'assets/images/museum4.jpg',
          'assets/images/museum5.jpg',
        ],
        placeName: 'The Egyptian Museum',
        cityOfPlace: 'Cairo',
        placeDescription:
            'The Egyptian Museum is the oldest archaeological museum in the Middle East, and houses the largest collection of Pharaonic antiquities in the world.',
        placeImage: 'assets/images/museum.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 6,
        placeImagesList: [
          'assets/images/pyramids.jpg',
          'assets/images/pyramids1.jpg',
          'assets/images/pyramids2.jpg',
          'assets/images/pyramids3.jpg',
          'assets/images/pyramids4.jpg',
        ],
        placeName: 'Giza pyramid',
        cityOfPlace: 'Giza',
        placeDescription:
            'The Great Pyramid and the Pyramid of Khafre are the largest pyramids built in ancient Egypt, and they have historically been common as emblems of Ancient Egypt ...',
        placeImage: 'assets/images/pyramids.jpg',
        placeRate: 9),
    PlaceModel(
        placeId: 7,
        placeImagesList: [
          'assets/images/PhilaeTemple.jpg',
          'assets/images/PhilaeTemple1.jpg',
          'assets/images/PhilaeTemple2.jpg',
          'assets/images/PhilaeTemple4.jpg',
        ],
        placeName: 'Philae Temple',
        cityOfPlace: 'Aswan',
        placeDescription:
            'The sacred Temple of Isis (more commonly known as Philae Temple) is one of Upper Egypt\'s most beguiling monuments both for the exquisite artistry of its reliefs and for the gorgeous symmetry of its architecture, which made it a favorite subject of Victorian painters.',
        placeImage: 'assets/images/PhilaeTemple.jpg',
        placeRate: 8),
    PlaceModel(
        placeId: 8,
        placeImagesList: [
          'assets/images/qanater.PNG',
          'assets/images/qanater1.jpg',
          'assets/images/qanater2.jpg',
          'assets/images/qanater3.jpg',
          'assets/images/qanater4.jpg',
          'assets/images/qanater5.jpg',
        ],
        placeName: 'El Qanater El-Khayreya',
        cityOfPlace: 'El Qalyubiya',
        placeDescription:
            'El Qanater El Khayreya is one of the major cities in El Qalyubiya Governorate in the north of Cairo, where the Nile splits off into the Damietta and Rosetta (or Rashid) Branches, marking the beginning of the Nile Delta.',
        placeImage: 'assets/images/qanater.PNG',
        placeRate: 9),
  ];

  static const SizedBox heightSpace = SizedBox(
    height: 5,
  );
  static const SizedBox widthSpace = SizedBox(
    width: 5,
  );
  static const String postsCollection = 'posts';
  static const String usersCollection = 'users';
  static const String placesCollection = 'placesReviews';
  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 30,
    color: Colors.black12, // Black color with 12% opacity
  );
}
