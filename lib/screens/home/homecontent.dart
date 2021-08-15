import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/home/productcard.dart';

class homeContent extends StatefulWidget {
  //const homeContent({Key? key}) : super(key: key);

  @override
  _homeContentState createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  @override
  Widget build(BuildContext context) {
    final Products = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Products.length == 0
          ? Align(
              alignment: Alignment.center,
              child: Text(
                " No Products are available\n         at the moment.",
                style: TextStyle(color: Colors.yellow[50], fontSize: 32.0),
              ),
            )
          : TweenAnimationBuilder(
              tween: Tween<double>(begin: 1, end: 0),
              duration: Duration(milliseconds: 500),
              builder: (BuildContext context, double _val, Widget? child) {
                return Padding(
                  padding: EdgeInsets.only(top: _val * 200),
                  child: child,
                );
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: Products[index],
                    );
                  }),
            ),
    );
  }
}
