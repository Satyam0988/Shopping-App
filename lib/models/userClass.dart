// ignore: camel_case_types
class userClass {
  final String uid;
  userClass({required this.uid});
}

class UserProfileData {
  final String uid;
  final String name;
  final String image;

  UserProfileData({required this.image, required this.name, required this.uid});
}

// class UserProductsList {
//   final String uid;
//   final List products;

//   UserProductsList({required this.products, required this.uid});
// }

class UserProductData {
  final String uid;
  final String company;
  final String model;
  final String modelYear;
  final String image;
  final String vinnumber;
  final String description;
  final int price;

  UserProductData(this.uid, this.company, this.model, this.modelYear,
      this.image, this.vinnumber, this.description, this.price);
}
