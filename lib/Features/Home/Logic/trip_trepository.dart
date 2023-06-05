import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';
import 'package:visit_egypt/Services/Push_Notifications/firebase_notifications.dart';

import '../../../Core/Constants/constants.dart';
import '../Model/tourguide_register_model.dart';
import '../View/Cubit/trips_cubit.dart';

abstract class TripRepo {
  handleJoinAndCancelTrip(String tripID, String tourGuideID, TripModel trip);
  startTrip(TripModel trip);
  endTrip(TripModel trip);
  Future createNewTrip(TripModel tripModel);
  Future<List<TripModel>> getAllCreatedTripsByUserId();
  Future<List<TripModel>> getAllcreatedTrips();
  updateTourGuideActiveAccountState(
      String userID, TourGuideApplicationEnum acceptActivation);
  Future<List<TourguideRegisterModel>> getPendingTourGuides();
}

class TripRepoImpl implements TripRepo {
  @override
  Future createNewTrip(TripModel tripModel) async {
    var docRef = tripCollectionAccess().doc();
    tripModel.tripID = docRef.id;
    FirebaseFirestore.instance
        .collection(Constants.allTrips)
        .doc()
        .set(tripModel.toMap());

    await docRef.set(tripModel.toMap());
    //.set(tripModel.toMap())
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

  @override
  Future<List<TripModel>> getAllcreatedTrips() async {
    List<TripModel> trips = [];
    var allDocs =
        await FirebaseFirestore.instance.collection(Constants.allTrips).get();

    for (var element in allDocs.docs) {
      trips.add(TripModel.fromMap(element.data()));
    }

    return trips;
  }

  @override
  handleJoinAndCancelTrip(
      String tripID, String tourGuideID, TripModel trip) async {
    bool isCancel = false;
    print("THE TOURGUIDE TOKEN IS :${trip.tourGuideToken}");
    var listOfJoiners = trip.usersJoinedIDs;
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;
    if (listOfJoiners!.contains(currentUserId)) {
      listOfJoiners.removeWhere((element) => element == currentUserId);
      isCancel = true;
    } else {
      listOfJoiners.add(currentUserId);
      print("user added");
    }
    await FirebaseFirestore.instance
        .collection(Constants.trip)
        .doc(tourGuideID)
        .collection('tripsCreated')
        .doc(tripID)
        .update({
      'usersJoinedIds': listOfJoiners,
      'numberOfJoiners':
          isCancel ? trip.numberOfJoiners - 1 : trip.numberOfJoiners + 1
    });
    var trips =
        await FirebaseFirestore.instance.collection(Constants.allTrips).get();
    var x =
        trips.docs.firstWhere((element) => element.data()['tripID'] == tripID);
    var id = x.id;
    await FirebaseFirestore.instance
        .collection(Constants.allTrips)
        .doc(id)
        .update({
      'usersJoinedIds': listOfJoiners,
      'numberOfJoiners':
          isCancel ? trip.numberOfJoiners - 1 : trip.numberOfJoiners + 1
    });
    FirebaseRemoteNotification fb = FirebaseRemoteNotification();
    if (!isCancel) {
      await fb.sendNotification('New Join !',
          'A new tourist just joined your trip !', trip.tourGuideToken);
    } else {
      await fb.sendNotification('Tourist Canceled !',
          'A  tourist just canceled his trip !', trip.tourGuideToken);
    }
  }

  @override
  startTrip(TripModel trip) async {
    await FirebaseFirestore.instance
        .collection(Constants.trip)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tripsCreated')
        .doc(trip.tripID.toString())
        .update({'isStarted': true});
    var trips =
        await FirebaseFirestore.instance.collection(Constants.allTrips).get();
    var x = trips.docs
        .firstWhere((element) => element.data()['tripID'] == trip.tripID);
    var id = x.id;
    FirebaseFirestore.instance
        .collection(Constants.allTrips)
        .doc(id)
        .update({'isStarted': true});
  }

  @override
  endTrip(TripModel trip) async {
    await FirebaseFirestore.instance
        .collection(Constants.trip)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tripsCreated')
        .doc(trip.tripID.toString())
        .delete();
    var trips =
        await FirebaseFirestore.instance.collection(Constants.allTrips).get();
    var x = trips.docs
        .firstWhere((element) => element.data()['tripID'] == trip.tripID);
    var id = x.id;
    await FirebaseFirestore.instance
        .collection(Constants.allTrips)
        .doc(id)
        .update({'hasEnded': true});
    // FirebaseFirestore.instance.collection(Constants.allTrips).doc(id).delete();
  }

  @override
  Future<List<TourguideRegisterModel>> getPendingTourGuides() async {
    var users = await FirebaseFirestore.instance.collection("users").get();
    List<TourguideRegisterModel> pendingGuides = [];
    for (var i in users.docs) {
      if (i.data()["userType"] == "tourguide" &&
          i.data()["isTourguideActivated"] == false) {
        pendingGuides.add(TourguideRegisterModel.fromMap(i.data())..id = i.id);
      }
    }
    return pendingGuides;
  }

  @override
  updateTourGuideActiveAccountState(
      String userID, TourGuideApplicationEnum state) async {
    await FirebaseFirestore.instance.collection("users").doc(userID).update({
      "isTourguideActivated": state == TourGuideApplicationEnum.accept
          ? true
          : state == TourGuideApplicationEnum.reject
              ? null
              : false
    });
  }
}
