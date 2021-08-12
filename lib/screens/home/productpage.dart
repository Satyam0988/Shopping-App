import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/errordialog.dart';

class ProductPage extends StatefulWidget {
  final UserProductData product;
  final bool addedToFavorites;
  final bool addedToCart;
  ProductPage(
      {required this.product,
      required this.addedToFavorites,
      required this.addedToCart});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool addedToCart = false;
  bool addedToFavorites = false;

  Future<void> _showErrorDialog(String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(error: error);
        });
  }

  @override
  void initState() {
    addedToFavorites = widget.addedToFavorites;
    addedToCart = widget.addedToCart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    final cartItems = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20.0, top: 5.0, bottom: 7.0),
              child: Container(
                width: 60.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    Text(
                      "${cartItems.length}",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.product.image),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "${widget.product.company}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38.0,
                    fontFamily: "Overlock"),
              ),
              Text(
                "${widget.product.model} - ${widget.product.modelYear}",
                style: TextStyle(
                    color: Colors.orange[200],
                    fontSize: 28.0,
                    fontFamily: "Nunito"),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "VIN Number : ${widget.product.vinnumber}",
                style: TextStyle(
                    color: Colors.white, fontSize: 20.0, fontFamily: "Nunito"),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text("${widget.product.description}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: "Nunito")),
              SizedBox(
                height: 15.0,
              ),
              Text("${widget.product.price}",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 28.0,
                      fontFamily: "Nunito")),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Seller: ${widget.product.soldBy}",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        addedToFavorites = !addedToFavorites;
                      });
                      if (addedToFavorites == true) {
                        dynamic result = await DatabaseService(uid: user!.uid)
                            .addProductToFavorites(
                                widget.product.soldBy,
                                widget.product.sellerUID,
                                widget.product.company,
                                widget.product.model,
                                widget.product.modelYear,
                                widget.product.image,
                                widget.product.price,
                                widget.product.vinnumber,
                                widget.product.description);
                        if (result != null) {
                          setState(() {
                            addedToFavorites = false;
                            _showErrorDialog("Could not add to Favorites");
                          });
                        } else {
                          setState(() {
                            addedToFavorites = true;
                          });
                        }
                      } else if (addedToFavorites == false) {
                        dynamic result = await DatabaseService(
                                uid: user!.uid,
                                CompanY: widget.product.company,
                                ModeL: widget.product.model,
                                ModelyeaR: widget.product.modelYear,
                                SelleruiD: widget.product.sellerUID)
                            .deleteProductFromFavorites();
                        if (result != null) {
                          setState(() {
                            addedToFavorites = true;
                            _showErrorDialog("Could not Delete from Favorites");
                          });
                        } else {
                          setState(() {
                            addedToFavorites = false;
                          });
                        }
                      }
                    },
                    child: Container(
                        height: 50.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 27.0,
                          color:
                              addedToFavorites ? Colors.red : Colors.grey[600],
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        addedToCart = !addedToCart;
                      });
                      if (addedToCart == true) {
                        dynamic result = await DatabaseService(uid: user!.uid)
                            .addProductToCart(
                                widget.product.soldBy,
                                widget.product.sellerUID,
                                widget.product.company,
                                widget.product.model,
                                widget.product.modelYear,
                                widget.product.image,
                                widget.product.price,
                                widget.product.vinnumber,
                                widget.product.description);
                        if (result != null) {
                          setState(() {
                            addedToCart = false;
                            _showErrorDialog("Could not add to Cart");
                          });
                        } else {
                          setState(() {
                            addedToCart = true;
                          });
                        }
                      } else if (addedToCart == false) {
                        dynamic result = await DatabaseService(
                                uid: user!.uid,
                                CompanY: widget.product.company,
                                ModeL: widget.product.model,
                                ModelyeaR: widget.product.modelYear,
                                SelleruiD: widget.product.sellerUID)
                            .deleteProductFromCart();
                        if (result != null) {
                          setState(() {
                            addedToCart = true;
                            _showErrorDialog("Could not Delete from Cart");
                          });
                        } else {
                          setState(() {
                            addedToCart = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: addedToCart ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                          child: addedToCart
                              ? Text("Added to Cart",
                                  style: TextStyle(
                                      color: Colors.yellow[50],
                                      fontSize: 24.0,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 24.0,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
