import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/orderdata.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/services/storage.dart';
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
    return await userCollection
        .doc(uid)
        .collection("Profile")
        .doc("ProfileData")
        .set({
      "name": "New Member",
      "image": defaultImageURL,
    });
  }

  Future updateUserProfileData(String name, String image) async {
    return await userCollection
        .doc(uid)
        .collection("Profile")
        .doc("ProfileData")
        .set({"name": name, "image": image})
        .then((value) => print("Updated User Profile Data"))
        .catchError((error) {
          return error;
        });
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
    await allProductsCollection
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
        })
        .then((value) => print("Added Product to All Products Collection"))
        .catchError((error) {
          return error;
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
        })
        .then((value) => print("Added Product to User's Product Collection"))
        .catchError((error) {
          return error;
        });
  }

  Future deleteProduct(bool addedToFavorites, bool addedToCart) async {
    if (addedToFavorites) {
      await userCollection
          .doc(uid)
          .collection("Favorites")
          .doc("$CompanY-$ModeL-$ModelyeaR-$uid")
          .delete()
          .then((value) => print("Deleted Product from Favorites"))
          .catchError((error) {
        return error;
      });
    }
    if (addedToCart) {
      await userCollection
          .doc(uid)
          .collection("Cart")
          .doc("$CompanY-$ModeL-$ModelyeaR-$uid")
          .delete()
          .then((value) => print("Deleted Product from Cart"))
          .catchError((error) {
        return error;
      });
    }
    await StorageService(
            uid: uid, company: CompanY, model: ModeL, modelYear: ModelyeaR)
        .deleteImage()
        .then((value) => print("Deleted image from Storage"))
        .catchError((error) {
      return error;
    });
    await allProductsCollection
        .doc("$CompanY-$ModeL-$ModelyeaR-$uid")
        .delete()
        .then((value) => print("Deleted Product from All Products collection"))
        .catchError((error) {
      return error;
    });
    return await userProductsCollection
        .doc(uid)
        .collection("Products")
        .doc("$CompanY-$ModeL-$ModelyeaR")
        .delete()
        .then((value) => print("Deleted Product from User Products collection"))
        .catchError((error) {
      return error;
    });
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
      String description,
      bool addedToFavorites,
      bool addedToCart) async {
    if (oldCompany == company &&
        oldModel == model &&
        oldModelYear == modelYear) {
      if (addedToFavorites) {
        await userCollection
            .doc(uid)
            .collection("Favorites")
            .doc("$company-$model-$modelYear-$uid")
            .update({
              "image": image,
              "price": price,
              "vinnumber": vinnumber,
              "description": description
            })
            .then((value) => print("Updated Product in Favorites"))
            .catchError((error) {
              return error;
            });
      }
      if (addedToCart) {
        await userCollection
            .doc(uid)
            .collection("Cart")
            .doc("$company-$model-$modelYear-$uid")
            .update({
              "image": image,
              "price": price,
              "vinnumber": vinnumber,
              "description": description
            })
            .then((value) => print("Updated Product in Cart"))
            .catchError((error) {
              return error;
            });
      }
      await allProductsCollection
          .doc("$company-$model-$modelYear-$uid")
          .update({
            "image": image,
            "price": price,
            "vinnumber": vinnumber,
            "description": description
          })
          .then((value) => print("Updated Product in All products Collection"))
          .catchError((error) {
            return error;
          });
      return await userProductsCollection
          .doc(uid)
          .collection("Products")
          .doc("$company-$model-$modelYear")
          .update({
            "image": image,
            "price": price,
            "vinnumber": vinnumber,
            "description": description
          })
          .then((value) =>
              print("Added updated Product to User Product collection"))
          .catchError((error) {
            return error;
          });
    } else {
      if (addedToFavorites) {
        await userCollection
            .doc(uid)
            .collection("Favorites")
            .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
            .delete()
            .then((value) => print("Deleted Product from Favorites"))
            .catchError((error) {
          return error;
        });
        await userCollection
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
            })
            .then((value) => print("Added updated Product to Favorites"))
            .catchError((error) {
              return error;
            });
      }
      if (addedToCart) {
        userCollection
            .doc(uid)
            .collection("Cart")
            .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
            .delete()
            .then((value) => print("Deleted Product from Cart"))
            .catchError((error) {
          return error;
        });
        await userCollection
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
            })
            .then((value) => print("Added updated Product to Cart"))
            .catchError((error) {
              return error;
            });
      }
      await allProductsCollection
          .doc("$oldCompany-$oldModel-$oldModelYear-$uid")
          .delete()
          .then(
              (value) => print("Deleted Product from All Products collection"))
          .catchError((error) {
        return error;
      });
      await allProductsCollection
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
          })
          .then((value) =>
              print("Added updated Product to All products Collection"))
          .catchError((error) {
            return error;
          });
      await userProductsCollection
          .doc(uid)
          .collection("Products")
          .doc("$oldCompany-$oldModel-$oldModelYear")
          .delete()
          .then(
              (value) => print("Deleted Product from User Products collection"))
          .catchError((error) {
        return error;
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
          })
          .then((value) =>
              print("Added updated Product to User Product collection"))
          .catchError((error) {
            return error;
          });
    }
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
        })
        .then((value) => print("Added Product to Favorites"))
        .catchError((error) {
          return error;
        });
  }

  Future deleteProductFromFavorites() async {
    return await userCollection
        .doc(uid)
        .collection("Favorites")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .delete()
        .then((value) => print("Deleted Product from Favorites"))
        .catchError((error) {
      return error;
    });
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
        })
        .then((value) => print("Added to Cart"))
        .catchError((error) {
          return error;
        });
  }

  Future deleteProductFromCart() async {
    return await userCollection
        .doc(uid)
        .collection("Cart")
        .doc("$CompanY-$ModeL-$ModelyeaR-$SelleruiD")
        .delete()
        .then((value) => print("Deleted from Cart"))
        .catchError((error) {
      return error;
    });
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
    }).catchError((error) {
      return error;
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
    return await userCollection
        .doc(uid)
        .collection("Orders")
        .doc()
        .set({
          "Product Count": cartItems.length,
          "Bill Value": billValue,
          "Products": products,
        })
        .then((value) => print("Order Placed"))
        .catchError((error) {
          return error;
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
