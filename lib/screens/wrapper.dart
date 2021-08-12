import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/authenticate/authenticate.dart';
import 'package:shopping_app/screens/home/home.dart';
import 'package:shopping_app/services/databse.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<List<UserProductData>>.value(
          value: DatabaseService(uid: user.uid).userCartlist,
          initialData: <UserProductData>[],
          child: Home());
    }
  }
}
