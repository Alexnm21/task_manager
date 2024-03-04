import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/ui/screens/login/login_screen.dart';
import 'package:task_manager/ui/widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  static const double inputPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            const BackGround(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(labelText: 'Nombre', icon: Icon(Icons.person, color: AppTheme.iconColor,), controller: _nameController),
                const SizedBox(height: inputPadding),
                CustomTextField(labelText: 'Correo Electrónico', controller: _emailController, keyboardType: TextInputType.emailAddress, icon: Icon(Icons.alternate_email, color: AppTheme.iconColor,)),
                const SizedBox(height: inputPadding),
                CustomTextField(labelText: 'Contraseña', controller: _passwordController, icon: Icon(Icons.lock_outline, color: AppTheme.iconColor,), obscureText: true,),
                const SizedBox(height: inputPadding),
                CustomTextField(labelText: 'Repetir Contraseña', controller: _confirmPasswordController, icon: Icon(Icons.lock_outline, color: AppTheme.iconColor,), obscureText: true,),
                const SizedBox(height: 32.0),

                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica de registro
                    // Puedes validar los campos y realizar la autenticación según tus necesidades
                    _handleSignUp();
                  },
                  child: const Text('Registrarse'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Get.off(()=>const LoginScreen());
                  }, 
                  child: const Text('Iniciar Sesión')
                  )
              ],
            ),
            const BackGround(),
          ],
        ),
      ),
    );
  }

  void _handleSignUp() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Realiza la validación de los campos
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      // Muestra un mensaje de error o realiza la lógica que desees
      return;
    }

    if (password != confirmPassword) {
      // Muestra un mensaje de error indicando que las contraseñas no coinciden
      return;
    }

    // Aquí puedes realizar la lógica de registro o autenticación
    // Por ejemplo, puedes llamar a un servicio de autenticación o guardar los datos en una base de datos

    // Después de realizar la lógica de registro, puedes navegar a otra pantalla si es necesario
  }
}



class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _Painter(),);
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
