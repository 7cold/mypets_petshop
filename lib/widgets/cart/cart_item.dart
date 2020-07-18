import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/datas/cart_data.dart';
import 'package:mypets_petshop/datas/product_data.dart';
import 'package:mypets_petshop/models/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartProducts cartProduct;

  CartItem(this.cartProduct);

  Widget build(BuildContext context) {
    Widget _buildProducts() {
      CartModel.of(context).updatePrices();

      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 10, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.productData.titulo,
                  ),
                  Text(
                    cartProduct.productData.precoNormal.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Material(
        elevation: 3,
        shadowColor: Colors.white,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: cartProduct.productData == null
                ? FutureBuilder<DocumentSnapshot>(
                    future: Firestore.instance
                        .collection('mypets_petshop')
                        .document('mypets_petshop')
                        .collection('produtos')
                        .document(cartProduct.pid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        cartProduct.productData =
                            ProductData.fromDocument(snapshot.data);
                        return _buildProducts();
                      } else {
                        return Center(
                          child: Text("carregando"),
                        );
                      }
                    },
                  )
                : _buildProducts()),
      ),
    );
  }
}
