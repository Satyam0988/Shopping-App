import 'package:flutter/material.dart';
import 'package:shopping_app/models/orderdata.dart';
import 'package:shopping_app/screens/settings/texttile.dart';

class OrderTile extends StatefulWidget {
  //const OrderTile({ Key? key }) : super(key: key);
  final OrderData order;
  final int Index;
  OrderTile({required this.order, required this.Index});

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        width: double.infinity,
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          color: Colors.yellow[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Order No ${widget.Index}",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.order.productCount,
                  itemBuilder: (context, index) {
                    return TextTile(
                      company: widget.order.products[index]['Company'],
                      model: widget.order.products[index]['Model'],
                      modelYear: widget.order.products[index]['ModelYear'],
                      price: widget.order.products[index]['Price'],
                    );
                  }),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Paid : ",
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      "\$${widget.order.billValue}",
                      style: TextStyle(fontSize: 22.0),
                    )
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
