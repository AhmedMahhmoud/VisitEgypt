import 'dart:core';
import 'dart:developer';

import 'package:visit_egypt/Core/Constants/constants.dart';

import '../../../FirebaseServices/Upload/firebase_upload_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/posts_model.dart';

abstract class PostsRepository {
  addNewPost(Posts post);
  likePost(String postID, newMap);
  Future<List<Posts>> getPostsByLocation(String location);
  List<Posts> retrieveAllPosts(List<QueryDocumentSnapshot> docs);
}

class PostsRepositoryImpl implements PostsRepository {
  @override
  addNewPost(Posts post) async {
    try {
      List<String> resultImageUrls = [];
      if (post.postImages.isNotEmpty) {
        FirebaseUploadImagesService firebaseUploadImagesService =
            FirebaseUploadImagesService();

        resultImageUrls = await firebaseUploadImagesService
            .uploadImagesToFirestore(post.postImages);
      }
      await FirebaseFirestore.instance.collection("posts").doc().set({
        'createdAt': post.createdAt,
        "postContent": post.postContent,
        "userID": post.userID,
        "postImages": resultImageUrls,
        "postOwnerName": post.postOwnerName,
        "likes": post.likes,
        "location": post.locationName
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  List<Posts> retrieveAllPosts(List<QueryDocumentSnapshot> docs) {
    List<Posts> retrievedPosts = [];

    for (var document in docs) {
      List<String> postImages = [];
      Map<dynamic, dynamic> tempPostLikes = document['likes'];
      Map<dynamic, dynamic> postLikes = {};
      for (int i = 0; i < document['postImages'].length; i++) {
        postImages.add(document['postImages'][i]);
      }

      tempPostLikes.forEach((key, value) {
        if (value == true) {
          postLikes.addAll({key: value});
        }
      }); //getUserNameByID(document['userID']);

      retrievedPosts.add(Posts(
          postImages: const [],
          likes: postLikes,
          postID: document.id,
          postOwnerName: document['postOwnerName'],
          postContent: document['postContent'],
          userID: document['userID'],
          retrievedPostImages: postImages,
          locationName: document['location']));
    }
    return retrievedPosts;
  }

  @override
  Future<void> likePost(postID, newMap) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postID)
        .update({"likes": newMap});
  }

  @override
  getPostsByLocation(String location) async {
    var response = await FirebaseFirestore.instance
        .collection(Constants.postsCollection)
        .get();
    var filteredResponse =
        response.docs.where((element) => element['location'] == location);

    return retrieveAllPosts(filteredResponse.toList());
  }
}
