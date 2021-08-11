import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/home/productcard.dart';

class homeContent extends StatefulWidget {
  const homeContent({Key? key}) : super(key: key);

  @override
  _homeContentState createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  @override
  Widget build(BuildContext context) {
    final Products = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: Products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: Products[index]);
          }),
    );
  }
}
