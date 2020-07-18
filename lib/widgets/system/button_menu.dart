import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';

class ButtonSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("object");
      },
      child: Material(
        elevation: 8,
        shadowColor: Color(corSecundaria).withAlpha(190),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 32,
          width: MediaQuery.of(context).size.width / 7,
          decoration: BoxDecoration(
            color: Color(corAccent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              //icon
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
                child: CircleAvatar(
                  backgroundColor: Color(corSecundaria),
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ),
              //text
              Text("Novo Serviço", style: fontRegular14White),
            ],
          ),
        ),
      ),
    );
  }
}
