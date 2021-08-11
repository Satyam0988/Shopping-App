import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/shared/constants.dart';

class DatabaseService {
  final String uid;
  final String CompanY;
  final String ModeL;
  final String ModelyeaR;
  DatabaseService(
      {this.uid = '', this.CompanY = '', this.ModeL = '', this.ModelyeaR = ''});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  final CollectionReference userProductsCollection =
      FirebaseFirestore.instance.collection("User Products");

  final CollectionReference allProductsCollection =
      FirebaseFirestore.instance.collection("All Products");

  Future setUserData() async {
    var batch = userCollection.firestore.batch();
    batch
        .set(userCollection.doc(uid).collection("Profile").doc("ProfileData"), {
      "name": "New Member",
      "image": defaultImageURL,
    });
    return await batch.commit();
  }

  Future updateUserProfileData(String name, String image) async {
    return await userCollection
        .doc(uid)
        .collection("Profile")
        .doc("ProfileData")
        .set({"name": name, "image": image});
  }

  Future addUserProductsData(
      String soldBy,
      String company,
      String model,
      String modelYear,
      String image,
      String price,
      String vinnumber,
      String description) async {
    allProductsCollection.doc("$company-$model-$modelYear-$uid").set({
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
    return await userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$company-$model-$modelYear")
        .set({
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
  }

  Future deleteProduct() async {
    allProductsCollection.doc("$CompanY-$ModeL-$ModelyeaR-$uid").delete();
    return await userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$CompanY-$ModeL-$ModelyeaR")
        .delete();
  }

  Future editUserProductsData(
      String oldCompany,
      String oldModel,
      String oldModelYear,
      String soldBy,
      String company,
      String model,
      String modelYear,
      String image,
      String price,
      String vinnumber,
      String description) async {
    allProductsCollection
        .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
        .delete();
    allProductsCollection.doc("$company-$model-$modelYear-$uid").set({
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
    userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$oldCompany-$oldModel-$oldModelYear")
        .delete();
    return await userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$company-$model-$modelYear")
        .set({
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
  }

  // userProfileData from snapshot
  UserProfileData _userProfileDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserProfileData(
        uid: uid, name: snapshot.get('name'), image: snapshot.get('image'));
  }

  List<UserProductData> _userProductsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserProductData(
        uid: uid,
        soldBy: doc.get('soldBy') ?? '',
        company: doc.get('company') ?? '',
        model: doc.get('model') ?? '',
        modelYear: doc.get('modelYear') ?? '',
        image: doc.get('image') ?? '',
        vinnumber: doc.get('vinnumber') ?? '',
        description: doc.get('description') ?? '',
        price: doc.get('price') ?? '',
      );
    }).toList();
  }

  UserProductData _userProductDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserProductData(
        uid: uid,
        soldBy: snapshot.get('soldBy'),
        company: snapshot.get('company'),
        model: snapshot.get('model'),
        modelYear: snapshot.get('modelYear'),
        image: snapshot.get('image'),
        vinnumber: snapshot.get('vinnumber'),
        description: snapshot.get('description'),
        price: snapshot.get('price'));
  }

  // get user profile doc stream
  Stream<UserProfileData> get userProfileData {
    return userCollection
        .doc(uid)
        .collection("Profile")
        .doc("ProfileData")
        .snapshots()
        .map(_userProfileDataFromSnapshot);
  }

  Stream<List<UserProductData>> get userProductsList {
    return userProductsCollection
        .doc(uid)
        .collection("Products")
        .snapshots()
        .map(_userProductsListFromSnapshot);
  }

  Stream<List<UserProductData>> get allUsersProductsList {
    return allProductsCollection.snapshots().map(_userProductsListFromSnapshot);
  }

  Stream<UserProductData> get userProductData {
    return userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$CompanY-$ModeL-$ModelyeaR")
        .snapshots()
        .map(_userProductDataFromSnapshot);
  }
}
