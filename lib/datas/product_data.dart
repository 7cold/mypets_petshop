import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;

  String titulo;
  double precoNormal;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    precoNormal = snapshot.data['preco_normal'] + 0.0;
    titulo = snapshot.data['titulo'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "titulo": titulo,
    };
  }
}
