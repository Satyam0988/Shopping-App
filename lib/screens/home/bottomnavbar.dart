import 'package:flutter/material.dart';
import 'package:shopping_app/shared/constants.dart';

// ignore: camel_case_types
class bottomNavBar extends StatefulWidget {
  //const bottomNavBar({Key? key}) : super(key: key);
  int selected;
  Function(int) tabChanged;
  bottomNavBar({required this.selected, required this.tabChanged});

  @override
  _bottomNavBarState createState() => _bottomNavBarState();
}

// ignore: camel_case_types
class _bottomNavBarState extends State<bottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int _selected = widget.selected;
    return Container(
      height: 65.0,
      width: double.infinity,
      decoration: customBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: (_selected == 1)
                ? selectedContainerDecoration
                : iconContainerDecoration,
            height: 64.0,
            width: 60.0,
            child: IconButton(
              onPressed: () {
                widget.tabChanged(1);
              },
              icon: Icon(Icons.home),
              iconSize: 35.0,
              color: (_selected == 1) ? Colors.green : Colors.yellow[50],
            ),
          ),
          Container(
            decoration: (_selected == 2)
                ? selectedContainerDecoration
                : iconContainerDecoration,
            height: 64.0,
            width: 60.0,
            child: IconButton(
              onPressed: () {
                widget.tabChanged(2);
              },
              icon: Icon(Icons.favorite),
              iconSize: 35.0,
              color: (_selected == 2) ? Colors.green : Colors.yellow[50],
            ),
          ),
          Container(
            decoration: (_selected == 3)
                ? selectedContainerDecoration
                : iconContainerDecoration,
            height: 64.0,
            width: 60.0,
            child: IconButton(
              onPressed: () {
                widget.tabChanged(3);
              },
              icon: Icon(Icons.settings),
              iconSize: 35.0,
              color: (_selected == 3) ? Colors.green : Colors.yellow[50],
            ),
          ),
          Container(
            decoration: (_selected == 4)
                ? selectedContainerDecoration
                : iconContainerDecoration,
            height: 64.0,
            width: 60.0,
            child: IconButton(
              onPressed: () {
                widget.tabChanged(4);
              },
              icon: Icon(Icons.shopping_bag),
              iconSize: 35.0,
              color: (_selected == 4) ? Colors.green : Colors.yellow[50],
            ),
          ),
          Container(
            decoration: (_selected == 5)
                ? selectedContainerDecoration
                : iconContainerDecoration,
            height: 64.0,
            width: 60.0,
            child: IconButton(
                onPressed: () {
                  widget.tabChanged(5);
                },
                icon: Icon(Icons.logout),
                iconSize: 35.0,
                color: (_selected == 5) ? Colors.green : Colors.yellow[50]),
          ),
        ],
      ),
    );
  }
}
