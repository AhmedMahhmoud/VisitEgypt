import 'package:task/Features/Posts/Model/posts_model.dart';

import '../../../FirebaseServices/Upload/firebase_upload_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostsRepository {
  addNewPost(Posts post) {}
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
      });
    } catch (e) {
      rethrow;
    }
  }
}
