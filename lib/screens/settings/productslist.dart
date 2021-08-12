import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/settings/addproductform.dart';
import 'package:shopping_app/screens/settings/producttile.dart';

class ProductsList extends StatefulWidget {
  //const ProductsList({Key? key}) : super(key: key);
  final String soldBy;
  ProductsList({required this.soldBy});

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Products = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Your Products",
          style: TextStyle(
              color: Colors.yellow[50],
              fontSize: 24.0,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: (Products.length == 0)
          ? (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You don't have any products in your list, click the button below to add a new product",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.yellow[50],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.add,
                      size: 40.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addProduct(
                                    soldBy: widget.soldBy,
                                  )));
                    }),
              ],
            ))
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Products.length,
                      itemBuilder: (context, index) {
                        return ProductTile(product: Products[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, bottom: 10.0, top: 15.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          tooltip: "Add a new Product",
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.add,
                            size: 40.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addProduct(
                                          soldBy: widget.soldBy,
                                        )));
                          }),
                    ),
                  ),
                ],
              )),
            ),
    );
  }
}
