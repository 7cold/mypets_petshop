import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corDark),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoTextField(
                      controller: email,
                      placeholder: "email",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CupertinoTextField(
                      controller: pass,
                      placeholder: "senha",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CupertinoButton(
                      child: Text("Entrar"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        model.login(
                          email: email.text,
                          pass: pass.text,
                          onSuccess: () {
                            print("ok");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()),
                                (Route<dynamic> route) => false);
                          },
                          onFail: () {
                            print("erro");
                          },
                        );
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      color: Color(corPrincipal2),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
