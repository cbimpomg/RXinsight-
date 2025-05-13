import 'package:flutter/material.dart';

class MedicineLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const MedicineLogo({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/medicine_logo.png',
      width: size,
      height: size,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to a simple icon if image fails to load
        return Icon(
          Icons.medication_outlined,
          size: size,
          color: color ?? Theme.of(context).primaryColor,
        );
      },
    );
  }
}
