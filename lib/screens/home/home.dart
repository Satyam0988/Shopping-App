import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/cart/cart.dart';
import 'package:shopping_app/screens/favorites/favorites.dart';
import 'package:shopping_app/screens/home/homecontent.dart';
import 'package:shopping_app/screens/logout/logout.dart';
import 'package:shopping_app/screens/settings/settings.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/screens/home/bottomnavbar.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dropdownValue = "All Products";
  late PageController _pageController = PageController();
  int selected = 1;

  Future<void> _showLogoutDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Logout();
        });
  }

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
    final user = Provider.of<userClass?>(context);
    final cartItems = Provider.of<List<UserProductData>>(context);

    return Scaffold(
      bottomNavigationBar: bottomNavBar(
        selected: selected,
        tabChanged: (tabNo) {
          if (tabNo != 5) {
            _pageController.animateToPage(tabNo - 1,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          } else {
            _showLogoutDialog();
          }
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80.0,
            decoration: customBoxDecoration,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  (selected == 1)
                      ? Expanded(child: Text("Home", style: regularBoldHeading))
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
                          color: Colors.yellow[50],
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
                            "${cartItems.length}",
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
          if (selected == 1)
            Container(
              padding: EdgeInsets.only(
                left: 250.0,
              ),
              height: 50.0,
              width: double.infinity,
              decoration: customBoxDecoration,
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: Colors.black,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    iconSize: 32.0,
                    elevation: 0,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue.toString();
                      });
                    },
                    items: <String>["All Products", "Your Products"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                  ),
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
                if (dropdownValue == "All Products")
                  StreamProvider<List<UserProductData>>.value(
                      value: DatabaseService().allUsersProductsList,
                      initialData: <UserProductData>[],
                      child: homeContent()),
                if (dropdownValue == "Your Products")
                  StreamProvider<List<UserProductData>>.value(
                      value: DatabaseService(uid: user!.uid).userProductsList,
                      initialData: <UserProductData>[],
                      child: homeContent()),
                StreamProvider<List<UserProductData>>.value(
                    value: DatabaseService(uid: user!.uid).userFavoriteslist,
                    initialData: <UserProductData>[],
                    child: FavoritesList()),
                StreamProvider<UserProfileData>.value(
                    value: DatabaseService(uid: user.uid).userProfileData,
                    initialData: UserProfileData(
                        image: defaultImageURL,
                        name: "New Member",
                        uid: user.uid),
                    child: Settings()),
                StreamProvider<List<UserProductData>>.value(
                    value: DatabaseService(uid: user.uid).userCartlist,
                    initialData: <UserProductData>[],
                    child: Cart()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
