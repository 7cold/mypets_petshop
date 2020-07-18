import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/datas/pets_data.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/users_screen.dart';
import 'package:mypets_petshop/widgets/system/back_button_custom.dart';
import 'package:mypets_petshop/widgets/users/item_pet.dart';
import 'package:scoped_model/scoped_model.dart';

class UserTodoDetailScreen extends StatefulWidget {
  final DocumentSnapshot doc;

  const UserTodoDetailScreen({Key key, this.doc}) : super(key: key);
  @override
  _UserTodoDetailScreenState createState() => _UserTodoDetailScreenState(doc);
}

class _UserTodoDetailScreenState extends State<UserTodoDetailScreen> {
  final DocumentSnapshot doc;

  _UserTodoDetailScreenState(this.doc);
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
              BackButtonCustom(
                function: () {
                  UserModel.of(context).changePageContent(UsersScreen());
                },
              ),
              //linha principal foto e dados
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(doc.data['imagem']),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          doc.data['nome'],
                          style: fontBold26White,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 35,
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 0),
                                  child: Text("Editar"),
                                  onPressed: () {},
                                  color: CupertinoColors.systemBlue,
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height: 35,
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 0),
                                  child: Text("Excluir"),
                                  onPressed: () {},
                                  color: CupertinoColors.systemFill,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              //dados de endereco
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dados",
                      style: fontBold20White,
                    ),
                    Text(
                      doc.data['endereco'] + ", " + doc.data['endereco_num'],
                      style: fontRegular16White2,
                    ),
                    Text(
                      doc.data['endereco_cidade'] +
                          ", " +
                          doc.data['endereco_bairro'],
                      style: fontRegular16White2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //titulo
              Row(children: [
                Text(
                  "Meus Pets",
                  style: fontBold20White,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5),
                  height: 30,
                  width: 30,
                  child: CupertinoButton(
                    child: Icon(Ionicons.ios_add),
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    color: Color(corPrincipal2),
                  ),
                )
              ]),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('mypets_petshop')
                    .document('mypets_petshop')
                    .collection('pets')
                    .where("idUser", isEqualTo: doc.documentID)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    default:
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(top: 30),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              PetsData data = PetsData.fromDocument(
                                  snapshot.data.documents[index]);
                              return ItemPets(data);
                            },
                          ));
                  }
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
