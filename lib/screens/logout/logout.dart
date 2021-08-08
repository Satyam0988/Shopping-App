import 'package:flutter/material.dart';
import 'package:shopping_app/services/auth.dart';

class Logout extends StatelessWidget {
  //const Logout({ Key? key }) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
            child: Text("Logout"),
            onPressed: () async {
              await _auth.signOut();
            }),
      ),
    );
  }
}
