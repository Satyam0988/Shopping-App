import 'package:flutter/material.dart';

// ignore: camel_case_types
class searchBox extends StatefulWidget {
  const searchBox({Key? key}) : super(key: key);

  @override
  _searchBoxState createState() => _searchBoxState();
}

// ignore: camel_case_types
class _searchBoxState extends State<searchBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 150.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 32.0,
              ),
            ),
            Text("Search"),
          ],
        ),
      ),
    );
  }
}
