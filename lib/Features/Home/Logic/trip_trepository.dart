import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';

import '../../../Core/Constants/constants.dart';

abstract class TripRepo {
  Future createNewTrip(TripModel tripModel);
  Future<List<TripModel>> getAllCreatedTripsByUserId();
}

class TripRepoImpl implements TripRepo {
  @override
  Future createNewTrip(TripModel tripModel) async {
    await tripCollectionAccess().doc().set(tripModel.toMap());
  }

  @override
  Future<List<TripModel>> getAllCreatedTripsByUserId() async {
    var response = await tripCollectionAccess().get();
    List<TripModel> trips = [];
    for (int i = 0; i < response.docs.length; i++) {
      trips.add(TripModel.fromMap(response.docs[i].data()));
      trips[i].tripID = response.docs[i].id;
    }
    return trips;
  }

  CollectionReference<Map<String, dynamic>> tripCollectionAccess() {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(Constants.trip)
        .doc(currentUserID)
        .collection('tripsCreated');
  }
}
