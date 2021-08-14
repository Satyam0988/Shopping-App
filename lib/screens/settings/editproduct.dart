import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/settings/addproductform.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/services/storage.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/errordialog.dart';
import 'package:shopping_app/shared/loading.dart';

// ignore: camel_case_types
class editProduct extends StatefulWidget {
  //const editProduct({Key? key}) : super(key: key);
  final UserProductData product;
  editProduct({required this.product});

  @override
  _editProductState createState() => _editProductState();
}

// ignore: camel_case_types
class _editProductState extends State<editProduct> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  dynamic image = "0";

  //form values
  String _currentCompany = "-1";
  String _currentModel = "-1";
  String _currentModelYear = "-1";
  String imageURL = "0";
  String _currentVINnumber = "-1";
  String _currentDescription = "-1";
  String _currentPrice = "-1";

  bool loading = false;
  bool pickedImage = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    bool addedToFavorites = false;
    DatabaseService(
            uid: user!.uid,
            CompanY: widget.product.company,
            ModeL: widget.product.model,
            ModelyeaR: widget.product.modelYear,
            SelleruiD: widget.product.sellerUID)
        .productInFavorites()
        .then((value) {
      value ? addedToFavorites = true : addedToFavorites = false;
    });

    bool addedToCart = false;
    DatabaseService(
            uid: user.uid,
            CompanY: widget.product.company,
            ModeL: widget.product.model,
            ModelyeaR: widget.product.modelYear,
            SelleruiD: widget.product.sellerUID)
        .productInCart()
        .then((value) {
      value ? addedToCart = true : addedToCart = false;
    });

    Future<void> _showErrorDialog(String error) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return errorDialog(error: error);
          });
    }

    return StreamBuilder<UserProductData>(
        stream: DatabaseService(
                uid: user.uid,
                CompanY: widget.product.company,
                ModeL: widget.product.model,
                ModelyeaR: widget.product.modelYear)
            .userProductData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }

          if (snapshot.hasData) {
            var userProductData = snapshot.data;
            return loading
                ? Loading()
                : Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.grey[900],
                      title: Text(
                        "Update this Product",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                    body: ListView(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 5.0, 20.0, 10.0),
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
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(color: Colors.white),
                                  initialValue: userProductData!.company,
                                  decoration: addProductInputDecoration,
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
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.next,
                                  initialValue: userProductData.model,
                                  decoration: addProductInputDecoration,
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
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.next,
                                  initialValue: userProductData.modelYear,
                                  decoration: addProductInputDecoration,
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
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.next,
                                  initialValue: userProductData.vinnumber,
                                  decoration: addProductInputDecoration,
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
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.next,
                                  initialValue: userProductData.description,
                                  decoration: addProductInputDecoration,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Image",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.yellow[50]),
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
                                          color: Colors.yellow[50],
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
                                          color: Colors.yellow[50],
                                        )),
                                  ],
                                ),
                                Visibility(
                                    visible: pickedImage,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 300.0,
                                          child: Text(
                                            pickedImage
                                                ? "${image.name}"
                                                : "Text",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                        Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Price",
                                    style: TextStyle(
                                      color: Colors.yellow[50],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.done,
                                  initialValue: userProductData.price,
                                  decoration: addProductInputDecoration,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter a Price"
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentPrice = val;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (pickedImage) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic res = await StorageService(
                                                uid: user.uid,
                                                imagePath: image.path,
                                                company: (_currentCompany ==
                                                        "-1")
                                                    ? userProductData.company
                                                    : _currentCompany,
                                                model: (_currentModel == "-1")
                                                    ? userProductData.model
                                                    : _currentModel,
                                                modelYear: (_currentModelYear ==
                                                        "-1")
                                                    ? userProductData.modelYear
                                                    : _currentModelYear)
                                            .uploadProductImage();
                                        if (res == null) {
                                          //print("Getting image");
                                          imageURL = await StorageService(
                                                  sellerUID: user.uid,
                                                  company: (_currentCompany ==
                                                          "-1")
                                                      ? userProductData.company
                                                      : _currentCompany,
                                                  model: (_currentModel == "-1")
                                                      ? userProductData.model
                                                      : _currentModel,
                                                  modelYear:
                                                      (_currentModelYear ==
                                                              "-1")
                                                          ? userProductData
                                                              .modelYear
                                                          : _currentModelYear)
                                              .getProductImage();
                                        }

                                        dynamic result = await DatabaseService(
                                                uid: user.uid,
                                                CompanY:
                                                    userProductData.company,
                                                ModeL: userProductData.model,
                                                ModelyeaR:
                                                    userProductData.modelYear,
                                                SelleruiD:
                                                    userProductData.sellerUID)
                                            .editUserProductsData(
                                                userProductData.company,
                                                userProductData.model,
                                                userProductData.modelYear,
                                                userProductData.soldBy,
                                                (_currentCompany == "-1")
                                                    ? userProductData.company
                                                    : _currentCompany,
                                                (_currentModel == "-1")
                                                    ? userProductData.model
                                                    : _currentModel,
                                                (_currentModelYear == "-1")
                                                    ? userProductData.modelYear
                                                    : _currentModelYear,
                                                imageURL,
                                                (_currentPrice == "-1")
                                                    ? userProductData.price
                                                    : _currentPrice,
                                                (_currentVINnumber == "-1")
                                                    ? userProductData.vinnumber
                                                    : _currentVINnumber,
                                                (_currentDescription == "-1")
                                                    ? userProductData
                                                        .description
                                                    : _currentDescription,
                                                addedToFavorites,
                                                addedToCart);
                                        if (result != null || res != null) {
                                          setState(() {
                                            loading = false;
                                          });
                                          _showErrorDialog(
                                              "Could not update the Product");
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
                                        dynamic result = await DatabaseService(
                                                uid: user.uid)
                                            .editUserProductsData(
                                                userProductData.company,
                                                userProductData.model,
                                                userProductData.modelYear,
                                                userProductData.soldBy,
                                                (_currentCompany == "-1")
                                                    ? userProductData.company
                                                    : _currentCompany,
                                                (_currentModel == "-1")
                                                    ? userProductData.model
                                                    : _currentModel,
                                                (_currentModelYear == "-1")
                                                    ? userProductData.modelYear
                                                    : _currentModelYear,
                                                userProductData.image,
                                                (_currentPrice == "-1")
                                                    ? userProductData.price
                                                    : _currentPrice,
                                                (_currentVINnumber == "-1")
                                                    ? userProductData.vinnumber
                                                    : _currentVINnumber,
                                                (_currentDescription == "-1")
                                                    ? userProductData
                                                        .description
                                                    : _currentDescription,
                                                addedToFavorites,
                                                addedToCart);
                                        if (result != null) {
                                          setState(() {
                                            loading = false;
                                            _showErrorDialog(
                                                "Could not Update the Product");
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
