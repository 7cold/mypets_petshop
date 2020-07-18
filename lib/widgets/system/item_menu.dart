import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';

class ItemMenu extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function function;

  const ItemMenu({Key key, this.label, this.iconData, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 30,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              iconData,
              size: 22,
              color: Color(corPrincipal),
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: fontRegular14White2,
            )
          ],
        ),
      ),
    );
  }
}
