import 'package:flutter/material.dart';
import 'package:task_manager/config/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Gradient? gradient;
  final Function() onPressed;

  const CustomButton({super.key, 
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.gradient, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: gradient, // Utiliza el gradiente si está presente, de lo contrario, usa el color sólido
        color: color ?? AppTheme.primary,
      ),
      child: TextButton(
        onPressed: () {
          // Acción cuando se presiona el botón
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
            if (icon != null) const SizedBox(width: 8.0),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}