import 'package:flutter/material.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/shared/errordialog.dart';

class Logout extends StatefulWidget {
  //const Logout({ Key? key }) : super(key: key);
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final AuthService _auth = AuthService();

  Future<void> _showErrorDialog(String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(error: error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
            child: Text("Logout"),
            onPressed: () async {
              dynamic result = await _auth.signOut();
              if (result == null) {
                _showErrorDialog("Could not Logout");
              }
            }),
      ),
    );
  }
}
