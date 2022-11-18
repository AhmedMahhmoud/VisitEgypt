import 'dart:core';

import '../../../FirebaseServices/Upload/firebase_upload_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/posts_model.dart';

abstract class PostsRepository {
  addNewPost(Posts post);

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
        "postContent": post.postContent,
        "userID": post.userID,
        "postImages": resultImageUrls,
        "location": post.locationName
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Posts> retrieveAllPosts(List<QueryDocumentSnapshot> docs) {
    List<Posts> retrievedPosts = [];

    for (var document in docs) {
      List<String> postImages = [];
      for (int i = 0; i < document['postImages'].length; i++) {
        postImages.add(document['postImages'][i]);
      }

      retrievedPosts.add(Posts(
          postImages: const [],
          postContent: document['postContent'],
          userID: document['userID'],
          retrievedPostImages: postImages,
          locationName: document['location']));
    }

    return retrievedPosts;
  }
}
