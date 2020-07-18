import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/resume_screen.dart';
import 'package:mypets_petshop/screens/user_detailTodo_screen.dart';
import 'package:mypets_petshop/widgets/system/back_button_custom.dart';
import 'package:mypets_petshop/widgets/users/item_user.dart';
import 'package:scoped_model/scoped_model.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonCustom(
                function: () {
                  UserModel.of(context).changePageContent(ResumeScreen());
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('mypets_petshop')
                    .document('mypets_petshop')
                    .collection('users')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    default:
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(top: 30),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              var dados = snapshot.data.documents[index];
                              return ItemUser(
                                doc: dados,
                                function: () {
                                  model.changePageContent(
                                      UserTodoDetailScreen(doc: dados));
                                },
                              );
                            },
                          ));
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
