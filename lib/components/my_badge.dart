import 'package:cabbbage/pages/marathonPage/marathon_func.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class MyBadge extends StatelessWidget {
  const MyBadge({super.key, required this.isChosen, required this.child});
  final int isChosen;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          padding: const EdgeInsets.all(3),
          badgeGradient: badges.BadgeGradient.linear(
            colors: isChosen == 2
                ? [
                    Colors.orange,
                    Colors.deepOrange,
                  ]
                : [
                    Colors.lightGreen,
                    Colors.green,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      position: badges.BadgePosition.topEnd(top: 0, end: -45),
      badgeContent: Text(
        chosenState(isChosen),
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
      child: child,
    );
  }
}
