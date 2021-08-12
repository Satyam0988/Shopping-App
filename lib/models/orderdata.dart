import 'package:shopping_app/models/userClass.dart';

class OrderData {
  final String uid;
  final int productCount;
  final double billValue;
  final List products;

  OrderData(
      {required this.uid,
      required this.billValue,
      required this.productCount,
      required this.products});
}
