import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/datas/product_data.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/product_detail_screen.dart';

class ItemProduct extends StatelessWidget {
  final ProductData data;

  const ItemProduct({this.data});

  @override
  Widget build(BuildContext context) {
    var preco = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    preco.updateValue(data.precoNormal);
    return GestureDetector(
      onTap: () {
        // CartProducts cartProduct = CartProducts();
        // cartProduct.quantidade = 1;
        // cartProduct.pid = data.id;
        // cartProduct.productData = data;
        // CartModel.of(context).addCartItem(cartProduct);

        // UserModel.of(context)
        //     .changePageContent(ProductDetailScreen(data: data));
      },
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        //shadowColor: Color(accentColor).withOpacity(0.22),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(corCinza),
          ),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: Image.network(
                      data.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Text(
                        data.titulo,
                        style: fontRegular14White2,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text(
                          preco.text,
                          style: fontBold14White,
                        ),
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
  }
}
