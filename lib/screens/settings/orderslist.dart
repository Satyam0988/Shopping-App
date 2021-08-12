import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/orderdata.dart';
import 'package:shopping_app/screens/settings/ordertile.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrderData>>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.yellow[50],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: (orders.length == 0)
          ? Center(
              child: Text(
                "You haven't placed any\n          Orders yet",
                style: TextStyle(
                  color: Colors.yellow[50],
                  fontSize: 32.0,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderTile(
                      order: orders[index], Index: orders.length - index);
                },
              ),
            ),
    );
  }
}
