import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/products_screen.dart';
import 'package:mypets_petshop/screens/users_screen.dart';
import 'package:mypets_petshop/widgets/resume/card_resume.dart';
import 'package:scoped_model/scoped_model.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  var totalUsers;
  var totalProducts;
  initGetUsers() async {
    totalUsers = await UserModel.of(context).getTotalUsers();
  }

  initGetProducts() async {
    totalProducts = await UserModel.of(context).getTotalProducts();
  }

  void initState() {
    super.initState();
    initGetUsers();
    initGetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resumo",
                  style: fontBold26White,
                ),
                Text(
                  "Veja seus dados em um breve resumo abaixo.",
                  style: fontRegular14White2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      CardResume(
                        img: "assets/icons/icon_user.png",
                        label: "Num. de Clientes",
                        labelButton: totalUsers == null
                            ? CupertinoActivityIndicator()
                            : Text(
                                totalUsers.toString(),
                                style: fontBold14White,
                              ),
                        rote: UsersScreen(),
                      ),
                      CardResume(
                        img: "assets/icons/icon_products.png",
                        label: "Num. de Produtos",
                        labelButton: totalProducts == null
                            ? CupertinoActivityIndicator()
                            : Text(
                                totalProducts.toString(),
                                style: fontBold14White,
                              ),
                        rote: ProductsScreen(),
                      ),
                    ],
                  ),
                )
              ]),
        );
      },
    );
  }
}
