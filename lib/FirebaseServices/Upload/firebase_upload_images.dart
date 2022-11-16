import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;


import '../firebase_services.dart';

class FirebaseUploadImagesService extends FirebaseServices {

  @override
  Future<List<String>> uploadImagesToFirestore(List<File> images) async {
    try {
      List<String> resultImageUrls = [];
      CollectionReference? imgRef =
          FirebaseFirestore.instance.collection('imageURLs');
      firebase_storage.Reference ref;
      for (var img in images) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images/${Path.basename(img.path)}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((url) {
            resultImageUrls.add(url);
            imgRef.add({'url': url});
          });
        });
      }
      return resultImageUrls;
    } catch (e) {
      rethrow;
    }
  }
}
