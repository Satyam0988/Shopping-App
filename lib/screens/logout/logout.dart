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
      height: 250.0,
      child: AlertDialog(
        backgroundColor: Colors.yellow[50],
        insetPadding: EdgeInsets.only(top: 230.0, bottom: 230.0),
        elevation: 5.0,
        title: Text(
          "Logout",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        content: Center(
          child: Text(
            "Are you sure you want to Logout?",
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "No",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              dynamic result = await _auth.signOut();
              if (result != null) {
                _showErrorDialog("Could not Logout");
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              "Yes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
