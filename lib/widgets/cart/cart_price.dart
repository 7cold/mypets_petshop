import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            double total = (price + ship - discount);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido".toUpperCase(),
                  style: fontBold14White,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal",
                      style: fontBold14White,
                    ),
                    Text(
                      price.toString(),
                      style: fontBold14White,
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Desconto",
                      style: fontBold14White,
                    ),
                    Text(
                      discount.toString(),
                      style: fontBold14White,
                    )
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: fontBold14White,
                    ),
                    Text(
                      total.toString(),
                      style: fontBold14White,
                    )
                  ],
                ),
                SizedBox(height: 30),
                CupertinoButton(
                    onPressed: buy, child: Text("Finalizar Pedido")),
              ],
            );
          },
        ),
      ),
    );
  }
}
