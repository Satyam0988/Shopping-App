import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/constants.dart';
// ignore: unused_import
import 'package:shopping_app/shared/loading.dart';
// ignore: unused_import
import 'package:shopping_app/widgets/gradientappbar.dart';

// ignore: camel_case_types
class addProduct extends StatefulWidget {
  const addProduct({Key? key}) : super(key: key);

  @override
  _addProductState createState() => _addProductState();
}

// ignore: camel_case_types
class _addProductState extends State<addProduct> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String _currentCompany = "-1";
  String _currentModel = "-1";
  String _currentModelYear = "-1";
  String _currentImage = "-1";
  String _currentVINnumber = "-1";
  String _currentDescription = "-1";
  int _currentPrice = -1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);

    return StreamBuilder<UserProductData>(
        stream: DatabaseService(uid: user!.uid).userProductsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.yellow[50],
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.brown[900],
                title: Text(
                  "Add a new Product",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                ),
              ),
              body: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Company",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter a Company name"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentCompany = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Model",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter a Model name"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentModel = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Model Year",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter a Model Year"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentModelYear = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "VIN Number",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter a VIN Number"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentVINnumber = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter a Description"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentDescription = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
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
                            decoration: textInputDecoration,
                            validator: (val) => val!.isEmpty
                                ? "Please enter an Image URL"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentImage = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: textInputDecoration,
                            validator: (val) =>
                                val!.isEmpty ? "Please enter a Price" : null,
                            onChanged: (val) {
                              setState(() {
                                _currentPrice = int.parse(val);
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                UserProductData product = UserProductData(
                                    user.uid,
                                    _currentCompany,
                                    _currentModel,
                                    _currentModelYear,
                                    _currentImage,
                                    _currentVINnumber,
                                    _currentDescription,
                                    _currentPrice);
                                await DatabaseService(uid: user.uid)
                                    .addUserProductsData(product);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: 150.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.brown[900],
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
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
