import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/models/cart_model.dart';
import 'package:mypets_petshop/screens/order_confirm_screen.dart';
import 'package:mypets_petshop/widgets/cart/cart_item.dart';
import 'package:mypets_petshop/widgets/cart/cart_price.dart';
import 'package:mypets_petshop/widgets/system/back_button_custom.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Timer timer;

  @override
  void initState() {
    timer = new Timer.periodic(Duration(seconds: 2), (Timer timer) {
      CartModel.of(context).updatePrices();
      print("atualizando carrinho");
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    print("cancel");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: BackButtonCustom(
          function: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(corDark),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.products == null || model.products.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não há Produtos,\nvolte para continuar!",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Column(
                  children: model.products.map((product) {
                    return CartItem(product);
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.white,
                  ),
                ),
                // DiscountCard(),
                CartPrice(() async {
                  // _carregando();
                  var prefMP = await model.preferenceGetMP();
                  String orderId = await model.finishOrder();
                  if (orderId != null) {
                    //enviarNotificacao();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderConfirmScreen(orderId, prefMP)),
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
