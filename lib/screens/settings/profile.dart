import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
// ignore: unused_import
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/screens/settings/editprofile.dart';
import 'package:transparent_image/transparent_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _showEditProfilePanel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.yellow[50],
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: editProfile(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileData = Provider.of<UserProfileData>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 20.0,
          ),
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            Center(
              child: SizedBox(
                height: 150.0,
                width: 150.0,
                child: ClipOval(
                    child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: userProfileData.image,
                  fit: BoxFit.fill,
                )),
              ),
            ),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                userProfileData.name,
                style: TextStyle(
                  color: Colors.yellow[50],
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 30.0,
              ),
              child: IconButton(
                onPressed: () async {
                  _showEditProfilePanel();
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow[50],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
