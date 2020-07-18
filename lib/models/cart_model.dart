import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:mypets_petshop/datas/cart_data.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProducts> products = [];

  String couponCode;
  String shipping = "irei_buscar";
  double precoEntrega = 0;
  int discountPercentage = 0;
  bool isLoading = false;
  bool carregandoEntrega = false;
  var resultRefIdMP;
  var mp = MP("4618697567453611", "7Vb1745xBCAbFfD6CmMFpDnkkTkZSZqs");

  CartModel(this.user) {
    if (user.isLogged() == true) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  Future<Map<String, dynamic>> preferenceGetMP() async {
    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    var preference = {
      "items": [
        {
          "title": "Produtos Nivaldo Motos",
          "quantity": 1,
          "currency_id": "BRL",
          "unit_price": productsPrice - discount + shipPrice
        }
      ],
      "payer": {
        "email": user.firebaseUser.email,
        "name": user.firebaseUser.uid
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "atm"},
        ]
      },
    };

    resultRefIdMP = await mp.createPreference(preference);

    print(resultRefIdMP);

    return resultRefIdMP;
  }

  void addCartItem(CartProducts cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection('mypets_petshop')
        .document("mypets_petshop")
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
    notifyListeners();
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProducts c in products) {
      if (c.productData != null)
        price += c.quantidade * c.productData.precoNormal;
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  void setShippingPrice(double precoEntrega) {
    this.precoEntrega = precoEntrega;
    notifyListeners();
  }

  double getShipPrice() {
    return precoEntrega;
  }

  void setShipping(String shipping) {
    this.shipping = shipping;
    notifyListeners();
  }

  String getShipping() {
    return shipping;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    String shipping = getShipping();
    double precoEntrega = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await Firestore.instance
        .collection("mypets_petshop")
        .document("mypets_petshop")
        .collection("ordens")
        .add({
      "usuarioId": user.firebaseUser.uid,
      "usuario_nome": user.userData['nome'],
      "produtos": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "preco_entrega": precoEntrega,
      "data": Timestamp.now(),
      "produtos_preco": productsPrice,
      "desconto": discount,
      "entrega": shipping,
      "preco_total": productsPrice - discount + precoEntrega,
      "status": 1,
      "refIdMP": resultRefIdMP['response']['id'],
      "payInfo": {
        "status": "",
        "id": "00000",
      }
    });

    await Firestore.instance
        .collection("mypets_petshop")
        .document("mypets_petshop")
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("ordens")
        .document(refOrder.documentID)
        .setData({
      "orderId": refOrder.documentID,
      "data": Timestamp.now(),
    });

    QuerySnapshot query = await Firestore.instance
        .collection("mypets_petshop")
        .document("mypets_petshop")
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    shipping = "";
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("mypets_petshop")
        .document("mypets_petshop")
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products =
        query.documents.map((doc) => CartProducts.fromDocument(doc)).toList();
    notifyListeners();
  }
}
