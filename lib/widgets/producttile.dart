import 'package:flutter/material.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/shared/constants.dart';

class ProductTile extends StatelessWidget {
  //const ProductTile({ Key? key }) : super(key: key);
  final UserProductData product;
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      decoration: customBoxDecoration,
    );
  }
}
