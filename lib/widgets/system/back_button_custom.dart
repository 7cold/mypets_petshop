import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';

class BackButtonCustom extends StatelessWidget {
  final Function function;

  const BackButtonCustom({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CupertinoButton(
          padding: EdgeInsets.only(left: 20),
          color: Color(corCinza),
          child: Row(
            children: [
              Icon(CupertinoIcons.back),
              Text("Voltar"),
            ],
          ),
          onPressed: function),
    );
  }
}
