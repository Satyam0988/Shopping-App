import 'package:flutter/material.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/home/productpage.dart';
import 'package:shopping_app/shared/constants.dart';

class ProductCard extends StatefulWidget {
  //const ProductCard({Key? key}) : super(key: key);
  final UserProductData product;
  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(product: widget.product)));
        },
        child: Container(
          height: 250.0,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    image: NetworkImage("${widget.product.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${widget.product.company} ${widget.product.model}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.price}",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
