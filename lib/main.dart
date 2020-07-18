import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:mypets_petshop/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'configs/cores.dart';
import 'models/cart_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle:
                    TextStyle(color: Colors.white, fontSize: 16),
                pickerTextStyle: TextStyle(color: Colors.white, fontSize: 12),
              )),
              primarySwatch: primary,
            ),
            home: HomeScreen(),
          ),
        );
      }),
    );
  }
}
