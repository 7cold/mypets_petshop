import 'package:cloud_firestore/cloud_firestore.dart';

class PetsData {
  String petId;
  String nome;
  Timestamp dataNasc;
  String tipo;
  String raca;
  String imagem;

  PetsData();

  PetsData.fromDocument(DocumentSnapshot document) {
    petId = document.documentID;
    nome = document.data['nome'];
    dataNasc = document.data['data_nasc'];
    tipo = document.data['tipo'];
    raca = document.data['raca'];
    imagem = document.data['imagem'];
  }
}
