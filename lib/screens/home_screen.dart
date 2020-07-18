import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/login_screen.dart';
import 'package:mypets_petshop/screens/user_detail_screen.dart';
import 'package:mypets_petshop/screens/users_screen.dart';
import 'package:mypets_petshop/services/upload_image/upload_image.dart';
import 'package:mypets_petshop/widgets/system/button_menu.dart';
import 'package:mypets_petshop/widgets/system/item_menu.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Flex(
            direction: Axis.horizontal,
            children: [
              //Menu
              w < 1250
                  ? SizedBox()
                  : Flexible(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(corCinza),
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                model.isLogged() == false
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          },
                                          child: Text(
                                            "Bem Vindo - Fazer Login",
                                            style: fontBold14White,
                                          ),
                                        ),
                                      )
                                    : Row(children: [
                                        //img
                                        InkWell(
                                          onTap: () async {
                                            //model.loadPets();
                                            var data = await Firestore.instance
                                                .collection("mypets_petshop")
                                                .document("mypets_petshop")
                                                .collection("users")
                                                .document(
                                                    model.firebaseUser.uid)
                                                .get();

                                            model.changePageContent(
                                                UserDetailScreen(
                                              doc: data,
                                            ));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: model.userData['nome'] ==
                                                      null
                                                  ? CupertinoActivityIndicator()
                                                  : Image.network(
                                                      model.userData['imagem']),
                                            ),
                                          ),
                                        ),
                                        //text
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              model.userData['nome'] == null
                                                  ? CupertinoActivityIndicator()
                                                  : Text(
                                                      model.userData['nome'],
                                                      style: fontBold16White,
                                                    ),
                                              SizedBox(height: 2),
                                              Text(
                                                model.userData['endereco']
                                                            .toString()
                                                            .length >
                                                        20
                                                    ? model.userData['endereco']
                                                            .toString()
                                                            .substring(0, 20) +
                                                        "..."
                                                    : model.userData['endereco']
                                                        .toString(),
                                                style: fontRegular14White2,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  model.logout();
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4),
                                                      child: Icon(
                                                        Ionicons.ios_log_out,
                                                        color:
                                                            Color(corPrincipal),
                                                        size: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      " logout",
                                                      style: fontBold14White,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                //Menu Lista
                                //botao
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: ButtonSystem(),
                                ),
                                //lista
                                SizedBox(height: 20),
                                ItemMenu(
                                  iconData: Ionicons.ios_search,
                                  label: "Consultar Clientes",
                                  function: () {
                                    model.changePageContent(UsersScreen());
                                  },
                                ),
                                ItemMenu(
                                  iconData: Ionicons.ios_search,
                                  label: "Consultar Animais",
                                ),
                                ItemMenu(
                                  iconData: Ionicons.ios_pulse,
                                  label: "Medicos",
                                ),
                                ItemMenu(
                                  iconData: Ionicons.ios_medkit,
                                  label: "Serviços",
                                ),
                                ItemMenu(
                                  iconData: Ionicons.ios_gift,
                                  label: "Produtos",
                                ),
                                ItemMenu(
                                  iconData: Ionicons.ios_card,
                                  label: "Pagamentos",
                                ),
                                ItemMenu(
                                    iconData: Ionicons.ios_document,
                                    label: "Relatórios"),
                              ]),
                        ),
                      ),
                    ),
              //Conteudo
              Flexible(
                flex: 3,
                child: Container(
                    color: Color(corDark),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 30, right: 30),
                        child: model.page)),
              ),
              //Menu Direita
              Flexible(
                flex: 1,
                child: Container(
                  color: Color(corCinza),
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
