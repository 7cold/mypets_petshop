import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypets_petshop/datas/product_data.dart';

class CartProducts {
  String cid;

  String pid;
  int quantidade;
  Timestamp date;

  ProductData productData;

  CartProducts();

  CartProducts.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    pid = document.data['pid'];
    quantidade = document.data['quantidade'];
    //date = document.data['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      "pid": pid,
      "quantidade": quantidade,
      //"date": date,
      "produto": productData.toResumeMap(),
    };
  }
}
