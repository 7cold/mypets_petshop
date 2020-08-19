import 'package:flutter/material.dart';
import 'package:mypets_petshop/datas/product_data.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/products_screen.dart';
import 'package:mypets_petshop/widgets/system/back_button_custom.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductData data;

  ProductDetailScreen({this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackButtonCustom(
          function: () {
            // UserModel.of(context).changePageContent(ProductsScreen());
          },
        ),
      ],
    );
  }
}
