import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/orderdata.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/settings/orderslist.dart';
import 'package:shopping_app/screens/settings/productslist.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/screens/settings/profile.dart';

class Settings extends StatefulWidget {
  //const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    final userProfileData = Provider.of<UserProfileData>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: StreamProvider<UserProfileData>.value(
          value: DatabaseService(uid: user!.uid).userProfileData,
          initialData: UserProfileData(
              image: defaultImageURL, name: "New Member", uid: user.uid),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Profile(),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<List<OrderData>>.value(
                                  value:
                                      DatabaseService(uid: user.uid).userOrders,
                                  initialData: <OrderData>[],
                                  child: OrdersList())));
                },
                child: Container(
                  height: 80.0,
                  width: 370.0,
                  child: Card(
                    color: Colors.yellow[50],
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 10.0,
                          ),
                          child: Icon(
                            Icons.history,
                            size: 32.0,
                          ),
                        ),
                        Text(
                          "Your Orders",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<List<UserProductData>>.value(
                                value: DatabaseService(uid: user.uid)
                                    .userProductsList,
                                initialData: <UserProductData>[],
                                child:
                                    ProductsList(soldBy: userProfileData.name),
                              )));
                },
                child: Container(
                  height: 80.0,
                  width: 370.0,
                  child: Card(
                    color: Colors.yellow[50],
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 10.0,
                          ),
                          child: Icon(
                            Icons.list,
                            size: 32.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Your Products",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 22.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
