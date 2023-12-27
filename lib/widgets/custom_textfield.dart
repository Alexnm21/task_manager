import 'package:flutter/material.dart';
import 'package:task_manager/config/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.text, required this.icon, required this.controller, this.keyboardType, this.obscureText = false});

  final String text;
  final Widget? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.inputBackground,
            blurRadius: 20,
            offset: const Offset(0,15)
          )
        ]
      ),
      child: TextField(  
        controller: controller,       
        keyboardType: keyboardType,
        obscureText: obscureText,
        scrollPadding: const EdgeInsets.symmetric(vertical: 20),
        cursorColor: AppTheme.primary,
        decoration: InputDecoration(                     
          labelText: text,
          hintStyle: const TextStyle(
            color: Color(0xff707277),
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: icon,  
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 247, 238, 238),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,  
            borderRadius: BorderRadius.circular(8),
          ),                 
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.primary, 
              width: 2
            ),   
            borderRadius: BorderRadius.circular(8),
          ),        
        ),
      ),
    );
  }
}