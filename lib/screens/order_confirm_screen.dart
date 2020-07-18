import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';

class OrderConfirmScreen extends StatelessWidget {
  final String orderId;
  final Map prefMP;
  OrderConfirmScreen(this.orderId, this.prefMP);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corDark),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Pedido realizado com sucesso!",
                style: fontBold14White,
              ),
              Text(
                prefMP['response']['init_point'],
                style: fontBold14White,
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Código do pedido: ',
                  style: fontBold14White,
                  children: <TextSpan>[
                    TextSpan(text: '$orderId', style: fontBold14White),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 5,
                shadowColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // ButtonFunction(
              //     function: () {
              //       Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => MyOrders()));
              //     },
              //     text: "meus pedidos"),
            ],
          ),
        ),
      ),
    );
  }
}
