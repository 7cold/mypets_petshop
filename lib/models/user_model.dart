import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/datas/pets_data.dart';
import 'package:mypets_petshop/screens/products_screen.dart';
import 'package:mypets_petshop/screens/resume_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  // StorageReference reference = FirebaseStorage.instance.ref().child(
  //     'mypets_petshop/pets/${Path.basename(DateTime.now().toString() + '.jpg')}');
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  bool loading = false;
  Map<String, dynamic> userData = Map();
  List<PetsData> pets = [];

  String urlWeb;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    loadCurrentUser();
  }

  refresh() {
    notifyListeners();
  }

  bool isLogged() {
    return firebaseUser != null;
  }

  logout() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void login({
    @required String email,
    @required String pass,
    @required VoidCallback onSuccess,
    @required VoidCallback onFail,
  }) async {
    loading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) async {
      firebaseUser = result.user;

      await loadCurrentUser();

      onSuccess();
      loading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      loading = false;
      notifyListeners();
    });
  }

  Future<Null> savePets(
      Map<String, dynamic> pets, String firebaseUserId) async {
    DocumentReference refOrder = await Firestore.instance
        .collection('mypets_petshop')
        .document('mypets_petshop')
        .collection('pets')
        .add(pets);

    await Firestore.instance
        .collection('mypets_petshop')
        .document('mypets_petshop')
        .collection('users')
        .document(firebaseUserId)
        .collection("pets")
        .document(refOrder.documentID)
        .setData({'idPet': refOrder.documentID});

    print("ok");
  }

  Future<Null> loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection('mypets_petshop')
            .document('mypets_petshop')
            .collection('users')
            .document(firebaseUser.uid)
            .get();

        userData = docUser.data;
        loadPets();
      }
      notifyListeners();
    }
  }

  Future<String> getTotalUsers() async {
    print("getUsers");
    final doc = await Firestore.instance
        .collection("mypets_petshop/mypets_petshop/users/")
        .getDocuments();
    final totalt = doc.documents.length;
    notifyListeners();
    return totalt.toString();
  }

  Future<String> getTotalProducts() async {
    print("getProd");
    final doc = await Firestore.instance
        .collection("mypets_petshop/mypets_petshop/produtos/")
        .getDocuments();
    final totalt = doc.documents.length;
    notifyListeners();
    return totalt.toString();
  }

  void loadPets() async {
    print("loadpets");
    QuerySnapshot query = await Firestore.instance
        .collection("mypets_petshop")
        .document("mypets_petshop")
        .collection("users")
        .document(firebaseUser.uid)
        .collection("pets")
        .getDocuments();

    pets = query.documents.map((doc) => PetsData.fromDocument(doc)).toList();
    notifyListeners();
  }
}
