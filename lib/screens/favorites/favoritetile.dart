import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/home/productpage.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/shared/errordialog.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoriteTile extends StatefulWidget {
  //const FavoriteTile({ Key? key }) : super(key: key);
  final UserProductData product;
  FavoriteTile({required this.product});

  @override
  _FavoriteTileState createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  Future<void> _showErrorDialog(String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(error: error);
        });
  }

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

    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StreamProvider<List<UserProductData>>.value(
                        value: DatabaseService(uid: user.uid).userCartlist,
                        initialData: <UserProductData>[],
                        child: ProductPage(
                          product: widget.product,
                          addedToFavorites: addedToFavorites,
                          addedToCart: addedToCart,
                        ),
                      )));
        },
        child: Container(
          width: double.infinity,
          height: 300.0,
          child: Column(
            children: <Widget>[
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                Container(
                  height: 200.0,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag:
                          "${widget.product.company}-${widget.product.model}-${widget.product.modelYear}-${widget.product.sellerUID}",
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.product.company} ${widget.product.model}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.product.price}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () async {
                        dynamic result = await DatabaseService(
                                uid: user.uid,
                                CompanY: widget.product.company,
                                ModeL: widget.product.model,
                                ModelyeaR: widget.product.modelYear,
                                SelleruiD: widget.product.sellerUID)
                            .deleteProductFromFavorites();
                        if (result != null) {
                          _showErrorDialog("Could not Delete from Favorites");
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.yellow[50],
                      ),
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
