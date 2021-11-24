import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/screens/productDetailsPage.dart';
import 'package:firstapp/services/firebase_services.dart';
import 'package:firstapp/widgets/customActionBar.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class HomeTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
          child: FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.getProductRef().get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Container(
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: Constant.regularHeadings,
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(top: 130.0, bottom: 12.0),
                  children: snapshot.data.docs.map((document) {
                    return Container(
                        height: 350.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          productId: document.id,
                                        )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 400.0,
                                width: 400.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: Image.network(
                                    document.data()['images'][0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        document.data()['name'],
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text("\$${document.data()['price']}",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
        CustomActionBar(
          title: "Home",
          hasTitle: true,
          hasBackArrow: false,
        ),
      ],
    );
  }
}
