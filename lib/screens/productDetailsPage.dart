import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constant.dart';
import 'package:firstapp/services/firebase_services.dart';
import 'package:firstapp/widgets/customActionBar.dart';
import 'package:firstapp/widgets/imageSwipe.dart';
import 'package:firstapp/widgets/productSizes.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  ProductDetail({this.productId});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  FirebaseServices _firebaseServices = FirebaseServices();

  final SnackBar _snackBar = SnackBar(
    content: Text('Added to Cart'),
  );
  String _selectedSize = "0";
  String _name = "";
  String _price = "";
  Future _addToCart() {
    return _firebaseServices
        .getUserRef()
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .doc(widget.productId)
        .set({
      "size": _selectedSize,
      'name': _name,
      'price': _price,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          FutureBuilder(
            future:
                _firebaseServices.getProductRef().doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imagesList = documentData['images'];
                List sizeList = documentData['sizes'];
                _selectedSize = "$sizeList[0]";
                _name = documentData['name'];
                _price = documentData['price'].toString();
                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imagesList: imagesList,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                      child: Text(
                        documentData['name'],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                      child: Text(
                        "\$${documentData['price']}",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                      child: Text(
                        documentData['description'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
                      child: Text(
                        'Select Sizes',
                        style: Constant.boldRegularHeadings,
                      ),
                    ),
                    ProducSizes(
                      sizeList: sizeList,
                      onSelected: (size) {
                        if (size == "0") {
                          _selectedSize = sizeList[0];
                        } else {
                          _selectedSize = size;
                        }
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 65.0,
                            width: 66.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Image(
                              height: 10.0,
                              width: 10.0,
                              image:
                                  AssetImage('assets/images/tab_saved@2x.png'),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: 65.0,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Center(
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      )),
    );
  }
}
