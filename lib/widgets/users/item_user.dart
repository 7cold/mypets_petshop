import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';

class ItemUser extends StatefulWidget {
  final DocumentSnapshot doc;
  final Function function;

  const ItemUser({@required this.doc, this.function});

  @override
  _ItemUserState createState() => _ItemUserState(doc, function);
}

class _ItemUserState extends State<ItemUser> {
  final DocumentSnapshot doc;
  final Function function;

  _ItemUserState(this.doc, this.function);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(corCinza),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //imagem
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(doc.data['imagem']),
              ),
            ),
            //textos
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.data['nome'],
                    style: fontBold16White,
                  ),
                  Text(
                    doc.data['endereco'] + ", " + doc.data['endereco_num'],
                    style: fontRegular14White2,
                  ),
                  Text(
                    doc.data['endereco_cidade'] +
                        " - " +
                        doc.data['endereco_bairro'],
                    style: fontRegular14White2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
