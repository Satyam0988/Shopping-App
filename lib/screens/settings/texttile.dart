import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  //const TextTile({ Key? key }) : super(key: key);
  final String company;
  final String model;
  final String modelYear;
  final String price;
  TextTile(
      {required this.company,
      required this.model,
      required this.modelYear,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$company-$model-$modelYear",
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            "$price",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
