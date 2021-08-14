import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final String uid;
  final dynamic imagePath;
  final String company;
  final String model;
  final String modelYear;
  final String sellerUID;
  StorageService(
      {this.uid = '',
      this.imagePath = '',
      this.company = '',
      this.model = '',
      this.modelYear = '',
      this.sellerUID = ''});

  final storageInstance = FirebaseStorage.instance;

  Future uploadProfileImage() async {
    try {
      Reference ref = storageInstance.ref("$uid/Profile/profile_image.jpg");
      UploadTask task = ref.putFile(File(imagePath));
      await task.whenComplete(() => null);
    } catch (e) {
      return e;
    }
  }

  Future getProfileImage() async {
    return await storageInstance
        .ref("$uid/Profile/profile_image.jpg")
        .getDownloadURL();
  }

  Future uploadProductImage() async {
    try {
      Reference ref =
          storageInstance.ref("$uid/Products/$company-$model-$modelYear.jpg");
      UploadTask task = ref.putFile(File(imagePath));
      await task.whenComplete(() => null);
    } catch (e) {
      return e;
    }
  }

  Future getProductImage() async {
    return await storageInstance
        .ref("$sellerUID/Products/$company-$model-$modelYear.jpg")
        .getDownloadURL();
  }

  Future deleteImage() async {
    storageInstance
        .ref("$uid/Products/$company-$model-$modelYear.jpg")
        .delete();
  }
}
