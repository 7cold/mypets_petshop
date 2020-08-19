import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/datas/product_data.dart';
import 'package:mypets_petshop/widgets/products/item_product.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection('mypets_petshop')
                  .document('mypets_petshop')
                  .collection('produtos')
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return snapshot.data.documents.length >= 1
                      ? GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.only(left: 25, right: 25, top: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: w < 650 ? 1 : w < 1012 ? 2 : 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio:
                                w < 650 ? 3 : w < 1012 ? 2.5 : 2.4,
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data.documents[index]);

                            return ItemProduct(data: data);
                          },
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Não há Produtos,\nvolte para continuar!",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
