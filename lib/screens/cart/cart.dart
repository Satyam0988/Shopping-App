import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/cart/carttile.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/errordialog.dart';

class Cart extends StatefulWidget {
  //const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<void> _showErrorDialog(String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(error: error);
        });
  }

  Future<void> _showOrderPlacedDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 250.0,
              child: AlertDialog(
                backgroundColor: Colors.yellow[50],
                insetPadding: EdgeInsets.only(top: 230.0, bottom: 230.0),
                elevation: 5.0,
                title: Text(
                  "Order Placed",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                content: Center(
                  child: Text(
                    "Order Placed Successfully!",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    final products = Provider.of<List<UserProductData>>(context);

    double billValue = 0;
    products.forEach((element) {
      billValue +=
          double.parse(element.price.substring(1, element.price.length - 1));
    });

    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: (products.length == 0)
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  "You haven't added any\n Products to Cart yet.",
                  style: TextStyle(color: Colors.yellow[50], fontSize: 32.0),
                ),
              )
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
                      child: GestureDetector(
                        onTap: () async {
                          dynamic result = await DatabaseService(uid: user!.uid)
                              .placeOrder(products, billValue);
                          if (result != null) {
                            _showErrorDialog("Could not place Order");
                          }
                          dynamic res = await DatabaseService(uid: user.uid)
                              .deleteAllProductsFromCart();
                          if (res != null) {
                            _showErrorDialog("Could not place Order");
                          } else {
                            _showOrderPlacedDialog();
                          }
                        },
                        child: Container(
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: Text(
                              "Place order for Cash on Delivery",
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 28.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "To Pay: ",
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 24.0),
                            ),
                            Text(
                              "\$$billValue",
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 24.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Container(
                        height: 30.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "Product Count: ",
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 24.0),
                            ),
                            Text(
                              "${products.length}",
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 24.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return CartTile(product: products[index]);
                        })
                  ],
                ),
              ));
  }
}
