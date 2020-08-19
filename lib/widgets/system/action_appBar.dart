import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/screens/cart_screen.dart';

class ActionAppBar extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget route;

  const ActionAppBar({Key key, this.label, this.icon, this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 30, bottom: 30),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Color(corPrincipal2),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(label),
          ],
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => route));
        },
      ),
    );
  }
}
