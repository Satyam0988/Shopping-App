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

class UserProductData {
  final String uid;
  final String soldBy;
  final String company;
  final String model;
  final String modelYear;
  final String image;
  final String vinnumber;
  final String description;
  final String price;

  UserProductData({
    required this.uid,
    required this.soldBy,
    required this.price,
    required this.company,
    required this.description,
    required this.image,
    required this.model,
    required this.modelYear,
    required this.vinnumber,
  });
}
