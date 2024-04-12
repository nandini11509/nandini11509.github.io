// TODO Implement this library.
import 'package:flutter/material.dart';

/// A custom widget that represents a sized icon button.
class SizedIconButton extends StatelessWidget {
  final double width;
  final IconData icon;
  final VoidCallback onPressed;

  const SizedIconButton({
    Key? key,
    required this.width,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: IconButton(
        iconSize: width * 0.6,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
