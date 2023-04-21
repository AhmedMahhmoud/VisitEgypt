import 'package:flutter/material.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';

import '../../Features/Home/Model/place_model.dart';
import '../../Features/MachineLearning/Model/predicted_place.dart';

class Constants {


  static const List<PlaceModel> allPlaces = [
    PlaceModel(
        placeLat: 29.98133015625794,
        placeLong: 31.13773777184683,
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
            'Sphinx - Abu al-Hol. The leonine Sphinx, known as Abu al-Hol (Father Of Terror) to the Arabs, has been guarding the Giza Plateau for about 4500 years. Located at the approach to the Khafre Pyramid & facing the sunrise, this statue is about 66 ft high & is the largest monolithic statue in the world. known in Arabic as Abu Al Hol (Father of Terror), this sculpture of a man with the haunches of a lion was dubbed the Sphinx by the ancient Greeks because it resembled their mythical winged monster who set riddles and killed anyone unable to answer them. A geological survey has shown that it was most likely carved from the bedrock at the bottom of the causeway during Khafre’s reign, so it probably portrays his features. As is clear from the accounts of early Arab travellers, the nose was hammered off sometime between the 11th and 15th centuries, although some still like to blame Napoleon for the deed. Part of the fallen beard was carted off by 19th-century adventurers and is now on display in the British Museum in London. These days the Sphinx has potentially greater problems: pollution and rising groundwater are causing internal fractures, and it is under a constant state of repair.Legends and superstitions about the Sphinx abound, and the mystery surrounding its long-forgotten purpose is almost as intriguing as its appearance. On seeing it for the first time, many visitors agree with English playwright Alan Bennett, who noted in his diary that seeing the Sphinx is like meeting a TV personality in the flesh: he’s smaller than one had imagined.',
        placeImage: 'assets/images/aboelhol.jpg',
        placeRate: 8),
    PlaceModel(
        placeLat: 22.728316423560162,
        placeLong: 32.72951202768114,
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
            'Abu Simbel is a historic site comprising two massive rock-cut temples in the village of Abu Simbel near the border with Sudan. It is situated on the western bank of Lake Nasser, about 230 km (140 mi) southwest of Aswan (about 300 km (190 mi) by road). The twin temples were originally carved out of the mountainside in the 13th century BC, during the 19th Dynasty reign of the Pharaoh Ramesses II. They serve as a lasting monument to the king Ramesses II. His wife Nefertari and children can be seen in smaller figures by his feet, considered to be of lesser importance and were not given the same position of scale. This commemorates his victory at the Battle of Kadesh. Their huge external rock relief figures have become iconic.The complex was relocated in its entirety in 1968 as part of the International Campaign to Save the Monuments of Nubia, under the supervision of a Polish archaeologist, Kazimierz Michałowski, from the Polish Centre of Mediterranean Archaeology University of Warsaw,[1] on an artificial hill made from a domed structure, high above the Aswan High Dam reservoir. The relocation of the temples – together with other temples which run from Abu Simbel downriver to Philae including Amada, Wadi es-Sebua, and other Nubian sites – was necessary or they would have been submerged during the creation of Lake Nasser, the massive artificial water reservoir formed after the building of the Aswan High Dam on the River Nile.[2][1] The Abu Simbel complex, and the other relocated temples, are part of the UNESCO World Heritage Site known as the "Nubian Monuments',
        placeImage: 'assets/images/abosimple.jpg',
        placeRate: 7),
    PlaceModel(
        placeLat: 30.04595558993511,
        placeLong: 31.22416347791308,
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
            'The Cairo Tower is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it is the tallest structure in Egypt and North Africa. Built from 1956 to 1961, the tower was designed by the Egyptian architect Naoum Shebib, inspired by the Ancient Egyptian Architecture.[1] Its partially open lattice-work design is intended to evoke a pharaonic lotus plant, an iconic symbol of Ancient Egypt.[8] The tower is crowned by a circular observation deck and a revolving restaurant[9] that rotate around its axis occasionally[10] with a view over greater Cairo.[11] According to documents published by Major General Adel Shaheen, the funds for the construction of the tower were originated from the Government of the United States through the CIA that represented by Kermit Roosevelt, which had provided around 3 million to Gamal Abdel Nasser as a personal gift to him with the intent of stopping his support for Algerian Revolution and other African independence movements.[8][12][13] Affronted by the attempt to bribe him, Nasser decided to publicly rebuke the U.S. government by transferring all of the funds to the Egyptian government for the use of the tower construction, which he stated that it would be "visible from the US Embassy just across the Nile, as a taunting symbol of Egypt , Africa and the Middle East\'s resistance, revolutions and pride".[12][14]',
        placeImage: 'assets/images/cairotower.jpg',
        placeRate: 7.5),
    PlaceModel(
        placeLat: 30.02959626596546,
        placeLong: 31.260698221694632,
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
            'The Great Mosque of Muhammad Ali Pasha or Alabaster Mosque is a mosque situated in the Citadel of Cairo in Egypt and was commissioned by Muhammad Ali Pasha . The mosque was built on the site of old Mamluk buildings in Cairo\'s Citadel between 1830 and 1848, although not completed until the reign of Said Pasha in 1857. The architect was Yusuf Boshnak from Istanbul and its model was the Sultan Ahmed Mosque[1][2] in that city. The ground on which the mosque was erected was built with debris from the earlier buildings of the Citadel.Before completion of the mosque, the alabastered panels from the upper walls were taken away and used for the palaces of Abbas I. The stripped walls were clad with wood painted to look like marble. In 1899, the mosque showed signs of cracking and some inadequate repairs were undertaken. The condition of the mosque became so dangerous that a complete scheme of restoration was ordered by King Fuad in 1931 and was finally completed under King Farouk in 1939. Muhammad Ali chose to build his state mosque entirely in the architectural style of his former overlords, the Ottomans, unlike the Mamluks who, despite their political submission to the Ottomans, stuck to the architectural styles of the previous Mamluk dynasties.The mosque was built with a central dome surrounded by four small and four semicircular domes. It was constructed in a square plan and measured 41x41 meters. The central dome is 21 meters in diameter and the height of the building is 52 meters. Two elegant cylindrical minarets of Turkish type with two balconies and conical caps are situated on the western side of the mosque, and rise to 82 meters.',
        placeImage: 'assets/images/mohamedali.jpg',
        placeRate: 9),
    PlaceModel(
        placeLat: 30.04835144175623,
        placeLong: 31.233659188237386,
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
            'The Egyptian Museum is the oldest archaeological museum in the Middle East, and houses the largest collection of Pharaonic antiquities in the world. The museum displays an extensive collection spanning from the Predynastic Period to the Greco-Roman Era.   The architect of the building was selected through an international competition in 1895, which was the first of its kind, and was won by the French architect, Marcel Dourgnon. The museum was inaugurated in 1902 by Khedive Abbas Helmy II, and has become a historic landmark in downtown Cairo, and home to some of the world’s most magnificent ancient masterpieces.  Among the museum’s unrivaled collection are the complete burials of Yuya and Thuya, Psusennes I and the treasures of Tanis, and the Narmer Palette commemorating the unification of Upper and Lower Egypt under one king, which is also among the museum’s invaluable artifacts. The museum also houses the splendid statues of the great kings Khufu, Khafre, and Menkaure, the builders of the pyramids at the Giza plateau. An extensive collection of papyri, sarcophagi and jewelry, among other objects, completes this uniquely expansive museum.',
        placeImage: 'assets/images/museum.jpg',
        placeRate: 8),
    PlaceModel(
        placeLat: 29.979438936150302,
        placeLong: 31.13458813439292,
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
            'The Great Pyramid and the Pyramid of Khafre are the largest pyramids built in ancient Egypt, and they have historically been common as emblems of Ancient Egypt , They were popularised in Hellenistic times, when the Great Pyramid was listed by Antipater of Sidon as one of the Seven Wonders of the World. It is by far the oldest of the Ancient Wonders and the only one still in existence. The Giza pyramid complex consists of the Great Pyramid (also known as the Pyramid of Cheops or Khufu and constructed c. 2580 – c. 2560 BC), the somewhat smaller Pyramid of Khafre (or Chephren) a few hundred metres to the south-west, and the relatively modest-sized Pyramid of Menkaure (or Mykerinos) a few hundred metres farther south-west. The Great Sphinx lies on the east side of the complex. Current consensus among Egyptologists is that the head of the Great Sphinx is that of Khafre. Along with these major monuments are a number of smaller satellite edifices, known as "queens" pyramids, causeways and valley pyramids',
        placeImage: 'assets/images/pyramids.jpg',
        placeRate: 9),
    PlaceModel(
        placeLat: 24.02566197900067,
        placeLong: 32.88420938450248,
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
            'The sacred Temple of Isis (more commonly known as Philae Temple) is one of Upper Egypt\'s most beguiling monuments both for the exquisite artistry of its reliefs and for the gorgeous symmetry of its architecture, which made it a favorite subject of Victorian painters. Philae is mentioned by numerous ancient writers, including Strabo,[7] Diodorus Siculus,[8] Ptolemy,[9] Seneca,[10] Pliny the Elder.[11] It was, as the plural name indicates, the appellation of two small islands situated in latitude 24° north, just above the First Cataract near Aswan (Egyptian Swenet "Trade;" Ancient Greek: Συήνη). Groskurd[12] computes the distance between these islands and Aswan at about 100 km (62 mi).Despite being the smaller island, Philae proper was, from the numerous and picturesque ruins formerly there, the more interesting of the two. Prior to the inundation, it was not more than 380 metres (1,250 ft) long and about 120 metres (390 ft) broad. It is composed of syenite: its sides are steep and on their summits a lofty wall was built encompassing the island.Since Philae was said to be one of the burying-places of Osiris, it was held in high reverence both by the Egyptians to the north and the Nubians (often referred to as "Ethiopians" in Greek) to the south. It was deemed profane for any but priests to dwell there and was accordingly sequestered and denominated "the Unapproachable" (Ancient Greek: ἄβατος).[13][14] It was reported too that neither birds flew over it nor fish approached its shores.[15] These indeed were the traditions of a remote period; since in the time of the Ptolemaic Kingdom, Philae was so much resorted to, partly by pilgrims to the tomb of Osiris, partly by persons on secular errands, that the priests petitioned Ptolemy VIII Physcon (170-117 BC) to prohibit public functionaries at least from coming there and living at their expense.',
        placeImage: 'assets/images/PhilaeTemple.jpg',
        placeRate: 8),
    PlaceModel(
        placeLat: 30.236529925884014,
        placeLong: 31.13759772462791,
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
            'El Qanater El Khayreya is one of the major cities in El Qalyubiya Governorate in the north of Cairo, where the Nile splits off into the Damietta and Rosetta (or Rashid) Branches, marking the beginning of the Nile Delta. It is located about 22km away from Cairo and there are a wide range of gardens, parks and agricultural area surrounding it. The city\'s name –which means \'The Dams of Welfare\'– is driven from Mohamed Ali Dam that was built in 1840 with the purpose to spare water and protect the Delta from the high floods. Since then, the site became a preferred resort for both the local and foreign tourists.From the Dam, various channels were caved to distribute water to the west, center and east of the Delta. The Dam itself is divided into two sections: one for Damietta Branch and the other for Rosetta Branch.',
        placeImage: 'assets/images/qanater.PNG',
        placeRate: 9),
  ];

  static const List<PredictedPlace> allPredictedPlaces = [
    PredictedPlace(placeName: 'Abo El Hol',placeDescription: 'Sphinx - Abu al-Hol. The leonine Sphinx, known as Abu al-Hol (Father Of Terror) to the Arabs, has been guarding the Giza Plateau for about 4500 years. Located at the approach to the Khafre Pyramid & facing the sunrise, this statue is about 66 ft high & is the largest monolithic statue in the world. known in Arabic as Abu Al Hol (Father of Terror), this sculpture of a man with the haunches of a lion was dubbed the Sphinx by the ancient Greeks because it resembled their mythical winged monster who set riddles and killed anyone unable to answer them. A geological survey has shown that it was most likely carved from the bedrock at the bottom of the causeway during Khafre’s reign, so it probably portrays his features. As is clear from the accounts of early Arab travellers, the nose was hammered off sometime between the 11th and 15th centuries, although some still like to blame Napoleon for the deed. Part of the fallen beard was carted off by 19th-century adventurers and is now on display in the British Museum in London. These days the Sphinx has potentially greater problems: pollution and rising groundwater are causing internal fractures, and it is under a constant state of repair.Legends and superstitions about the Sphinx abound, and the mystery surrounding its long-forgotten purpose is almost as intriguing as its appearance. On seeing it for the first time, many visitors agree with English playwright Alan Bennett, who noted in his diary that seeing the Sphinx is like meeting a TV personality in the flesh: he’s smaller than one had imagined.', placeLat: 29.98133015625794, placeLng: 31.13773777184683),
    PredictedPlace(placeName: 'Abu Simbel Temple',placeDescription: 'Abu Simbel is a historic site comprising two massive rock-cut temples in the village of Abu Simbel near the border with Sudan. It is situated on the western bank of Lake Nasser, about 230 km (140 mi) southwest of Aswan (about 300 km (190 mi) by road). The twin temples were originally carved out of the mountainside in the 13th century BC, during the 19th Dynasty reign of the Pharaoh Ramesses II. They serve as a lasting monument to the king Ramesses II. His wife Nefertari and children can be seen in smaller figures by his feet, considered to be of lesser importance and were not given the same position of scale. This commemorates his victory at the Battle of Kadesh. Their huge external rock relief figures have become iconic.The complex was relocated in its entirety in 1968 as part of the International Campaign to Save the Monuments of Nubia, under the supervision of a Polish archaeologist, Kazimierz Michałowski, from the Polish Centre of Mediterranean Archaeology University of Warsaw,[1] on an artificial hill made from a domed structure, high above the Aswan High Dam reservoir. The relocation of the temples – together with other temples which run from Abu Simbel downriver to Philae including Amada, Wadi es-Sebua, and other Nubian sites – was necessary or they would have been submerged during the creation of Lake Nasser, the massive artificial water reservoir formed after the building of the Aswan High Dam on the River Nile.[2][1] The Abu Simbel complex, and the other relocated temples, are part of the UNESCO World Heritage Site known as the "Nubian Monuments', placeLat: 30.04595558993511, placeLng: 31.22416347791308),
    PredictedPlace(placeName: 'Cairo Tower',placeDescription: 'The Cairo Tower is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it is the tallest structure in Egypt and North Africa. Built from 1956 to 1961, the tower was designed by the Egyptian architect Naoum Shebib, inspired by the Ancient Egyptian Architecture.[1] Its partially open lattice-work design is intended to evoke a pharaonic lotus plant, an iconic symbol of Ancient Egypt.[8] The tower is crowned by a circular observation deck and a revolving restaurant[9] that rotate around its axis occasionally[10] with a view over greater Cairo.[11] According to documents published by Major General Adel Shaheen, the funds for the construction of the tower were originated from the Government of the United States through the CIA that represented by Kermit Roosevelt, which had provided around 3 million to Gamal Abdel Nasser as a personal gift to him with the intent of stopping his support for Algerian Revolution and other African independence movements.[8][12][13] Affronted by the attempt to bribe him, Nasser decided to publicly rebuke the U.S. government by transferring all of the funds to the Egyptian government for the use of the tower construction, which he stated that it would be "visible from the US Embassy just across the Nile, as a taunting symbol of Egypt , Africa and the Middle East', placeLat: 22.728316423560162, placeLng: 32.72951202768114),
    PredictedPlace(placeName: 'Giza pyramid',placeDescription: 'The Great Pyramid and the Pyramid of Khafre are the largest pyramids built in ancient Egypt, and they have historically been common as emblems of Ancient Egypt , They were popularised in Hellenistic times, when the Great Pyramid was listed by Antipater of Sidon as one of the Seven Wonders of the World. It is by far the oldest of the Ancient Wonders and the only one still in existence. The Giza pyramid complex consists of the Great Pyramid (also known as the Pyramid of Cheops or Khufu and constructed c. 2580 – c. 2560 BC), the somewhat smaller Pyramid of Khafre (or Chephren) a few hundred metres to the south-west, and the relatively modest-sized Pyramid of Menkaure (or Mykerinos) a few hundred metres farther south-west. The Great Sphinx lies on the east side of the complex. Current consensus among Egyptologists is that the head of the Great Sphinx is that of Khafre. Along with these major monuments are a number of smaller satellite edifices, known as "queens" pyramids, causeways and valley pyramids', placeLat: 29.979438936150302, placeLng: 31.13458813439292),
    PredictedPlace(placeName: 'Tutankhamun',placeDescription: 'was the antepenultimate pharaoh of the Eighteenth Dynasty of ancient Egypt. He ascended to the throne around the age of nine and reigned until his death around the age of nineteen. The most significant actions of his reign were reversing the societal changes enacted by his predecessor, Akhenaten, during the Amarna Period: Tutankhamun restored the traditional polytheistic form of ancient Egyptian religion, undoing the religious shift known as Atenism, and moved the royal court away from Akhenaten\'s capital, Amarna. Tutankhamun was one of few kings worshipped as a deity during his lifetime; this was usually done posthumously for most pharaohs.[7] In popular culture, he is known for his vastly opulent wealth found during the 1922 discovery of his tomb, KV62, the only such tomb to date to have been found in near-intact condition.[8] The discovery of his tomb is widely considered one of the greatest archaeological discoveries of all time', placeLat: 25.740389, placeLng: 32.601417),

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
  static const String trip = 'trip';
  static const String allTrips = 'allTrips';
  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 30,
    color: Colors.black12, // Black color with 12% opacity
  );
}

InputDecoration textFieldDecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: CustomColors.greyK),
      borderRadius: BorderRadius.circular(10)),
);
