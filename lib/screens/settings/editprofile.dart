import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/services/storage.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/errordialog.dart';

// ignore: camel_case_types
class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

// ignore: camel_case_types
class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  dynamic image = "0";

  //form values
  String _currentName = "0";
  String imageURL = "0";

  Future<void> _showErrorDialog(String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(error: error);
        });
  }

  bool loading = false;
  bool pickedImage = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);

    return StreamBuilder<UserProfileData>(
        stream: DatabaseService(uid: user!.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            _showErrorDialog("Something went wrong");
          }

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
                    autofocus: true,
                    textInputAction: TextInputAction.next,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Image",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w300),
                      ),
                      IconButton(
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.camera);
                            if (image != null) {
                              setState(() {
                                pickedImage = true;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 28.0,
                          )),
                      IconButton(
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                pickedImage = true;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.photo,
                            size: 28.0,
                          )),
                    ],
                  ),
                  Visibility(
                      visible: pickedImage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.0,
                            child: Text(
                              pickedImage ? "${image.name}" : "Text",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        ],
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (pickedImage) {
                          setState(() {
                            loading = true;
                          });
                          //print("uploading image");
                          dynamic res = await StorageService(
                                  uid: user.uid, imagePath: image.path)
                              .uploadProfileImage();
                          if (res == null) {
                            //print("Getting image");
                            imageURL = await StorageService(uid: user.uid)
                                .getProfileImage();
                          }
                          dynamic result = await DatabaseService(uid: user.uid)
                              .updateUserProfileData(
                                  (_currentName == "0")
                                      ? userProfileData.name
                                      : _currentName,
                                  (imageURL == "0")
                                      ? userProfileData.image
                                      : imageURL);
                          if (result != null || res != null) {
                            setState(() {
                              loading = false;
                              _showErrorDialog("Could not Update Profile");
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          }
                        } else {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await DatabaseService(uid: user.uid)
                              .updateUserProfileData(
                                  (_currentName == "0")
                                      ? userProfileData.name
                                      : _currentName,
                                  userProfileData.image);
                          if (result != null) {
                            setState(() {
                              loading = false;
                              _showErrorDialog("Could not Update Profile");
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          }
                        }
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
                        child: Stack(children: <Widget>[
                          Visibility(
                            visible: !loading,
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: loading,
                              child: SizedBox(
                                height: 25.0,
                                width: 25.0,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ))
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
