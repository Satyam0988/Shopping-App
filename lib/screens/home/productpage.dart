import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/userClass.dart';

class ProductPage extends StatefulWidget {
  //const ProductPage({ Key? key }) : super(key: key);
  final UserProductData product;
  ProductPage({required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 7.0, top: 5.0, bottom: 7.0),
              child: Container(
                width: 60.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                      "4",
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
                    onTap: () {},
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
                          color: Colors.grey[600],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                          child: Text(
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
