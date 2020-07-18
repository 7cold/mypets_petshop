import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/datas/pets_data.dart';

class ItemPets extends StatelessWidget {
  final PetsData petsData;

  ItemPets(this.petsData);

  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: Firestore.instance
          .collection('mypets_petshop')
          .document('mypets_petshop')
          .collection('pets')
          .document(petsData.petId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //meus pets
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //card com dados pets
                Column(children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      //imagem
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            snapshot.data['imagem'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //textos
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data['nome'],
                                  style: fontRegular16White2),
                              Text(
                                  '${formatDate(snapshot.data['data_nasc'].toDate(), [
                                    dd,
                                    '/',
                                    mm,
                                    '/',
                                    yyyy,
                                  ])}',
                                  style: fontRegular16White2),
                              Text(snapshot.data['raca'],
                                  style: fontRegular16White2),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 0),
                                      child: Text("Editar"),
                                      onPressed: () {},
                                      color: CupertinoColors.systemBlue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 0),
                                      child: Text("Excluir"),
                                      onPressed: () {},
                                      color: CupertinoColors.systemFill,
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                ]),
              ]);
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
