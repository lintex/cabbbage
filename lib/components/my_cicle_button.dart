import 'package:flutter/material.dart';

class MyCicleButton extends StatelessWidget {
  const MyCicleButton(
      {super.key, required this.buttonIcon, required this.onPressed});
  final IconData buttonIcon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
      child: IconButton(
          icon: Icon(buttonIcon), iconSize: 20, onPressed: onPressed),
    );
  }
}
