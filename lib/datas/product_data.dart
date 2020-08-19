import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;

  String titulo;
  String img;
  String descricao;
  double precoNormal;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    precoNormal = snapshot.data['preco_normal'] + 0.00;
    titulo = snapshot.data['titulo'];
    img = snapshot.data['img'];
    descricao = snapshot.data['descricao'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "titulo": titulo,
      "preco_normal": precoNormal,
    };
  }
}
