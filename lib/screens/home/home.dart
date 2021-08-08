import 'package:flutter/material.dart';
import 'package:shopping_app/screens/logout/logout.dart';
import 'package:shopping_app/screens/settings/settings.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/widgets/bottomnavbar.dart';
import 'package:shopping_app/widgets/searchBox.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController = PageController();
  int selected = 1;

  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(
        selected: selected,
        tabChanged: (tabNo) {
          _pageController.animateToPage(tabNo - 1,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100.0,
            decoration: customBoxDecoration,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  (selected == 1)
                      ? searchBox()
                      : (selected == 2)
                          ? Expanded(
                              child:
                                  Text("Favorites", style: regularBoldHeading))
                          : (selected == 3)
                              ? Expanded(
                                  child: Text("Settings",
                                      style: regularBoldHeading))
                              : (selected == 4)
                                  ? Expanded(
                                      child: Text("Cart",
                                          style: regularBoldHeading))
                                  : Expanded(
                                      child: Text("Logout",
                                          style: regularBoldHeading)),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Container(
                      width: 60.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                            size: 25.0,
                          ),
                          Text(
                            "4",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //content to display
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (pageNo) {
                setState(() {
                  selected = pageNo + 1;
                });
              },
              children: <Widget>[
                Container(
                  child: Center(
                    child: Text("HomePage"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("Favorites"),
                  ),
                ),
                Settings(),
                Container(
                  child: Center(
                    child: Text("Cart"),
                  ),
                ),
                Logout(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
