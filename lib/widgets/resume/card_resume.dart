import 'package:flutter/material.dart';
import 'package:mypets_petshop/configs/cores.dart';
import 'package:mypets_petshop/configs/fonts.dart';
import 'package:mypets_petshop/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CardResume extends StatelessWidget {
  final String img;
  final String label;
  final Widget labelButton;
  final Widget rote;

  const CardResume(
      {@required this.img,
      @required this.label,
      @required this.labelButton,
      @required this.rote});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return GestureDetector(
          onTap: () {
            // model.changePageContent(rote);
          },
          child: Container(
            height: 160,
            width: 220,
            decoration: BoxDecoration(
              color: Color(corCinza),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(corCinza),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 10, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              label,
                              style: fontRegular14White2,
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color(corDark),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: labelButton),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                  child: Container(
                    height: 100,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Color(corCinza),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
