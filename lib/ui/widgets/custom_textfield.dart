import 'package:flutter/material.dart';
import 'package:task_manager/config/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.labelText, required this.icon, required this.controller, this.keyboardType, this.obscureText = false, this.hintText, this.errorText, this.onChanged,  this.margin = const EdgeInsets.symmetric(vertical: 10)});

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
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
        onChanged: onChanged,
        controller: controller,       
        keyboardType: keyboardType,
        obscureText: obscureText,
        scrollPadding: const EdgeInsets.symmetric(vertical: 20),
        cursorColor: AppTheme.primary,
        decoration: InputDecoration(          
          labelText: labelText,
          hintText:  hintText,
          errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
          error: errorWidget(),
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

  errorWidget(){
    if(errorText == null) return null;
    return  Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.redAccent),
        const SizedBox(width: 5,),
        Text(errorText!, style: const TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),)
      ],
    );
  }
}