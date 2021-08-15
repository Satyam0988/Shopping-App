import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/userClass.dart';
import 'package:shopping_app/screens/home/productpage.dart';
import 'package:shopping_app/services/databse.dart';
import 'package:shopping_app/screens/settings/editproduct.dart';
import 'package:shopping_app/shared/errordialog.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTile extends StatefulWidget {
  //const ProductTile({ Key? key }) : super(key: key);
  final UserProductData product;
  ProductTile({required this.product});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userClass?>(context);
    bool addedToFavorites = false;

    Future<void> _showErrorDialog(String error) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return errorDialog(error: error);
          });
    }

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
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
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
          //decoration: customBoxDecoration,
          child: Card(
            elevation: 5.0,
            color: Colors.yellow[50],
            child: ListTile(
              leading: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: SizedBox(
                      height: 10.0,
                      width: 10.0,
                      child: CircularProgressIndicator()),
                ),
                Hero(
                  tag:
                      "${widget.product.company}-${widget.product.model}-${widget.product.modelYear}-${widget.product.sellerUID}",
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.product.image,
                    height: 150.0,
                    width: 70.0,
                  ),
                ),
              ]),
              title: Text(
                "${widget.product.company}  ${widget.product.model}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "${widget.product.price}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editProduct(
                                    product: widget.product,
                                  )));
                    },
                    icon: Icon(Icons.edit),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: () async {
                      dynamic result = DatabaseService(
                              uid: user.uid,
                              CompanY: widget.product.company,
                              ModeL: widget.product.model,
                              ModelyeaR: widget.product.modelYear)
                          .deleteProduct(addedToFavorites, addedToCart);
                      if (result == null) {
                        _showErrorDialog("Could not delete Product");
                      }
                    },
                    icon: Icon(Icons.delete),
                    padding: EdgeInsets.only(left: 5.0),
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
