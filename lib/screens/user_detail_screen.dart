import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/datas/pets_data.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/services/upload_image/upload_image.dart';
import 'package:mypets_petshop/widgets/users/item_pet.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserDetailScreen extends StatefulWidget {
  final DocumentSnapshot doc;

  const UserDetailScreen({Key key, this.doc}) : super(key: key);
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState(doc);
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  // Timer timer;

  // @override
  // void initState() {
  //   timer = new Timer.periodic(Duration(seconds: 3), (Timer timer) {
  //     UserModel.of(context).refresh();
  //     print("atualizando...");
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   print("cancel");
  //   super.dispose();
  // }

  final DocumentSnapshot doc;
  String valueTipo;
  String urlImage;
  DateTime dataNasc;
  TextEditingController tipo = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController raca = TextEditingController();
  double status;

  showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Escolha o Tipo'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Cão'),
            onPressed: () {
              setState(() {
                tipo.text = "Cão";
                valueTipo = "cao";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gato'),
            onPressed: () {
              setState(() {
                tipo.text = "Gato";
                valueTipo = "gato";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Hamster'),
            onPressed: () {
              setState(() {
                tipo.text = "Hamster";
                valueTipo = "hamster";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Coelho'),
            onPressed: () {
              setState(() {
                tipo.text = "Coelho";
                valueTipo = "coelho";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Pássaro'),
            onPressed: () {
              setState(() {
                tipo.text = "Pássaro";
                valueTipo = "passsaro";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Porco'),
            onPressed: () {
              setState(() {
                tipo.text = "Porco";
                valueTipo = "porco";
                Navigator.pop(context);
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Cavalo'),
            onPressed: () {
              setState(() {
                tipo.text = "Cavalo";
                valueTipo = "cavalo";
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }

  showSelTipo() {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text(
            "Adicionar Pet",
            style: fontRegular16White2,
          ),
          backgroundColor: Color(corDark),
          content: Container(
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 10),
                CupertinoTextField(
                  placeholder: "Nome",
                  controller: nome,
                ),
                SizedBox(height: 5),
                CupertinoTextField(
                  onTap: () {
                    showPicker();
                  },
                  readOnly: true,
                  placeholder: "Tipo",
                  controller: tipo,
                ),
                SizedBox(height: 5),
                CupertinoTextField(
                  placeholder: "Raça",
                  controller: raca,
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  height: 60,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (dateTime) {
                        dataNasc = dateTime;
                      }),
                ),
                SizedBox(
                  height: 35,
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      UrlUtils.uploadImage();
                    },
                    child: Text("Image Select."),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: CupertinoColors.systemBlue,
                        onPressed: () {
                          urlImage = UrlUtils.getUrl();
                          if (urlImage == "error") {
                            Navigator.pop(context);
                            UrlUtils.resetUrl();
                            setState(() {
                              urlImage = "";
                              nome.text = "";
                              tipo.text = "";
                              raca.text = "";
                            });
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: CupertinoColors.destructiveRed,
                                behavior: SnackBarBehavior.floating,
                                content: Text('Erro. Imagem superior a 5mb.'),
                              ),
                            );
                          } else {
                            UserModel.of(context).savePets(
                                {
                                  'imagem': urlImage.toString(),
                                  'nome': nome.text,
                                  'tipo': valueTipo.toString(),
                                  'raca': raca.text,
                                  'data_nasc': Timestamp.fromDate(dataNasc),
                                  'idUser':
                                      UserModel.of(context).firebaseUser.uid,
                                },
                                UserModel.of(context)
                                    .firebaseUser
                                    .uid).catchError((e) {
                              print(e);
                            });
                            setState(() {
                              urlImage = "";
                              nome.text = "";
                              tipo.text = "";
                              raca.text = "";
                            });
                            UrlUtils.resetUrl();
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Salvar"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        onPressed: () {
                          nome.text = "";
                          tipo.text = "";
                          raca.text = "";
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _UserDetailScreenState(this.doc);
  @override
  Widget build(BuildContext context) {
    print("iniciando pag detail..");
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        //model.refresh();
        return model.userData['nome'] == null
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //linha principal foto e dados
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
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
                                    kIsWeb == true
                                        ? SizedBox(
                                            height: 35,
                                            child: CupertinoButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 0),
                                              child: Text("Editar"),
                                              onPressed: () {},
                                              color: CupertinoColors.systemBlue,
                                            ),
                                          )
                                        : SizedBox(
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
                            doc.data['endereco'] +
                                ", " +
                                doc.data['endereco_num'],
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
                          onPressed: () {
                            showSelTipo();
                          },
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
                          .where("idUser", isEqualTo: model.firebaseUser.uid)
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
