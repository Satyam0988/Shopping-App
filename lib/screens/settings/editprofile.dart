import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/loading.dart';

// ignore: camel_case_types
class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

// ignore: camel_case_types
class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String _currentName = "0";
  String _currentImage = "0";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);

    return StreamBuilder<UserProfileData>(
        stream: DatabaseService(uid: user!.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfileData? userProfileData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Update your Profile",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: userProfileData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Image URL",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: userProfileData.image,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter an image url" : null,
                    onChanged: (val) {
                      setState(() {
                        _currentImage = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid)
                            .updateUserProfileData(
                                (_currentName == "0")
                                    ? userProfileData.name
                                    : _currentName,
                                (_currentImage == "0")
                                    ? userProfileData.image
                                    : _currentImage);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 150.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
