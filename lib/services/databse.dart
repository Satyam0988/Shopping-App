// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/shared/constants.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future setUserData() async {
    var batch = FirebaseFirestore.instance.batch();
    const array = ["Cart", "Products", "Favorites", "Orders", "Profile"];
    array.forEach((col) {
      var docRef = userCollection.doc(uid).collection("$col").doc("$uid-$col");
      (col == "Profile")
          ? batch.set(docRef, {
              "name": "New Member",
              "image": defaultImageURL,
            })
          : (col == "Orders")
              ? batch.set(docRef, {"orders": []})
              : batch.set(docRef, {"products": []});
    });
    return await batch.commit();
  }

  Future updateUserProfileData(String name, String image) async {
    return await userCollection
        .doc(uid)
        .collection("Profile")
        .doc("$uid-Profile")
        .set({"name": name, "image": image});
  }

  Future addUserProductsData(UserProductData product) async {
    return await userCollection
        .doc(uid)
        .collection("Products")
        .doc("$uid-Products")
        .set({
      "products": FieldValue.arrayUnion([product])
    }, SetOptions(merge: true));
  }
  // //brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Brew(
  //       name: doc.get('name') ?? '',
  //       sugars: doc.get('sugars') ?? '0',
  //       strength: doc.get('strength') ?? 0,
  //     );
  //   }).toList();
  // }

  // userProfileData from snapshot
  UserProfileData _userProfileDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserProfileData(
        uid: uid, name: snapshot.get('name'), image: snapshot.get('image'));
  }

  List<UserProductData> _userProductsListFromSnapshot(
      DocumentSnapshot snapshot) {
    return snapshot.get('products');
  }
  // //get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // get user profile doc stream
  Stream<UserProfileData> get userProfileData {
    return userCollection
        .doc(uid)
        .collection("Profile")
        .doc("$uid-Profile")
        .snapshots()
        .map(_userProfileDataFromSnapshot);
  }

  Stream<List<UserProductData>> get userProductsList {
    return userCollection
        .doc(uid)
        .collection("Products")
        .doc("$uid-Products")
        .snapshots()
        .map(_userProductsListFromSnapshot);
  }
}
