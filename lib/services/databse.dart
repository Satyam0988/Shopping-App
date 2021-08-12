import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/orderdata.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/shared/constants.dart';

class DatabaseService {
  final String uid;
  final String CompanY;
  final String ModeL;
  final String ModelyeaR;
  final String SelleruiD;
  DatabaseService(
      {this.uid = '',
      this.CompanY = '',
      this.ModeL = '',
      this.ModelyeaR = '',
      this.SelleruiD = ''});

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
      "sellerUID": uid,
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
      "sellerUID": uid,
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
    userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$CompanY-$ModeL-$ModelyeaR-$uid")
        .delete();
    userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$CompanY-$ModeL-$ModelyeaR-$uid")
        .delete();
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
    userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
        .delete();
    userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$company-$model-$modelYear-$uid")
        .set({
      "sellerUID": uid,
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
    userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
        .delete();
    userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$company-$model-$modelYear-$uid")
        .set({
      "sellerUID": uid,
      "soldBy": soldBy,
      "company": company,
      "model": model,
      "modelYear": modelYear,
      "image": image,
      "price": price,
      "vinnumber": vinnumber,
      "description": description
    });
    allProductsCollection
        .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
        .delete();
    allProductsCollection.doc("$company-$model-$modelYear-$uid").set({
      "sellerUID": uid,
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
      "sellerUID": uid,
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

  Future addProductToFavorites(
      String soldBy,
      String sellerUID,
      String company,
      String model,
      String modelYear,
      String image,
      String price,
      String vinnumber,
      String description) async {
    return await userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$company-$model-$modelYear-$sellerUID")
        .set({
      "sellerUID": sellerUID,
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

  Future deleteProductFromFavorites() async {
    return await userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .delete();
  }

  Future addProductToCart(
      String soldBy,
      String sellerUID,
      String company,
      String model,
      String modelYear,
      String image,
      String price,
      String vinnumber,
      String description) async {
    return await userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$company-$model-$modelYear-$sellerUID")
        .set({
      "sellerUID": sellerUID,
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

  Future deleteProductFromCart() async {
    return await userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .delete();
  }

  Future deleteAllProductsFromCart() async {
    return await userCollection
        .doc(uid)
        .collection("Cart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future placeOrder(List<UserProductData> cartItems, double billValue) async {
    List products = [];
    for (int i = 0; i < cartItems.length; i++) {
      products.add({
        "Company": cartItems[i].company,
        "Model": cartItems[i].model,
        "ModelYear": cartItems[i].modelYear,
        "Price": cartItems[i].price
      });
    }
    return await userCollection.doc(uid).collection("Orders").doc().set({
      "Product Count": cartItems.length,
      "Bill Value": billValue,
      "Products": products,
    });
  }

  Future<bool> productInFavorites() async {
    var snapshot = await userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> productInCart() async {
    var snapshot = await userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
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
        sellerUID: doc.get('sellerUID') ?? '',
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
        sellerUID: snapshot.get('sellerUID'),
        soldBy: snapshot.get('soldBy'),
        company: snapshot.get('company'),
        model: snapshot.get('model'),
        modelYear: snapshot.get('modelYear'),
        image: snapshot.get('image'),
        vinnumber: snapshot.get('vinnumber'),
        description: snapshot.get('description'),
        price: snapshot.get('price'));
  }

  List<OrderData> _userOrdersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OrderData(
        uid: uid,
        billValue: doc.get('Bill Value') ?? -1,
        productCount: doc.get('Product Count') ?? -1,
        products: doc.get('Products') ?? [],
      );
    }).toList();
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

  Stream<List<UserProductData>> get userFavoriteslist {
    return userCollection
        .doc(uid)
        .collection("Favorites")
        .snapshots()
        .map(_userProductsListFromSnapshot);
  }

  Stream<List<UserProductData>> get userCartlist {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .snapshots()
        .map(_userProductsListFromSnapshot);
  }

  Stream<List<OrderData>> get userOrders {
    return userCollection
        .doc(uid)
        .collection("Orders")
        .snapshots()
        .map(_userOrdersListFromSnapshot);
  }

  Stream<UserProductData> get userProductData {
    return userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$CompanY-$ModeL-$ModelyeaR")
        .snapshots()
        .map(_userProductDataFromSnapshot);
  }

  Stream<UserProductData> get userFavoritesData {
    return userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .snapshots()
        .map(_userProductDataFromSnapshot);
  }

  Stream<UserProductData> get userCartData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .snapshots()
        .map(_userProductDataFromSnapshot);
  }
}
