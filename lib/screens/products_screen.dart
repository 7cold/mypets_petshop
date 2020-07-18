import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/datas/cart_data.dart';
import 'package:mypets_petshop/datas/product_data.dart';
import 'package:mypets_petshop/models/cart_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection('mypets_petshop')
            .document('mypets_petshop')
            .collection('produtos')
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("data"));
          } else {
            return snapshot.data.documents.length >= 1
                ? GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 25, right: 25, top: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProductData data = ProductData.fromDocument(
                          snapshot.data.documents[index]);

                      return GestureDetector(
                        onTap: () {
                          CartProducts cartProduct = CartProducts();
                          cartProduct.quantidade = 1;
                          cartProduct.pid = data.id;
                          cartProduct.productData = data;
                          CartModel.of(context).addCartItem(cartProduct);

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => CartScreen()));
                        },
                        child: Material(
                          elevation: 7,
                          //shadowColor: Color(accentColor).withOpacity(0.22),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Material(
                                          color: Colors.transparent,
                                          child: Text(data.titulo +
                                              " - " +
                                              data.precoNormal.toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
    );
  }
}
