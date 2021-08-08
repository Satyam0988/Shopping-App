import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/widgets/addproductform.dart';
import 'package:shopping_app/widgets/producttile.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Products = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        title: Text(
          "Your Products",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
        ),
      ),
      body: (Products.length == 0)
          ? (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You don't have any products in your list, click the button below to add a new product",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addProduct()));
                    }),
              ],
            ))
          : (ListView(
              children: <Widget>[
                ListView.builder(
                  itemCount: Products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(product: Products[index]);
                  },
                ),
                FloatingActionButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addProduct()));
                }),
              ],
            )),
    );
  }
}
