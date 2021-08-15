import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/favorites/favoritetile.dart';

class FavoritesList extends StatefulWidget {
  //const FavoritesList({Key? key}) : super(key: key);

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: (products.length == 0)
          ? Align(
              alignment: Alignment.center,
              child: Text(
                "   You haven't added any\n Products to Favorites yet.",
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
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return FavoriteTile(
                      product: products[index],
                    );
                  }),
            ),
    );
  }
}
