import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                AppTheme.primary,
                AppTheme.light
              ]
            )
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 0, left: 20),
                    child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 40,),
                Expanded(
                  child: SlideInUp(
                    from: Get.height / 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children:[
                            const SizedBox(height: 40),
                            CustomTextField(text: 'Email', icon: Icon(Icons.alternate_email_outlined, color: AppTheme.iconColor), controller: TextEditingController()),
                            const SizedBox(height: 20),
                            CustomTextField(text: 'Contraseña', icon: Icon(Icons.lock_outline, color: AppTheme.iconColor), controller: TextEditingController()),
                            const SizedBox(height: 30),
                            const Text('¿Olvidaste la contraseña?', style: TextStyle(color: Colors.grey, fontSize: 16),),
                            const Spacer(),
                            SizedBox(width:200, child: CustomButton(text: 'Iniciar Sesión', onPressed: (){}, gradient: LinearGradient(colors: [AppTheme.secondary, AppTheme.light]),)),
                            const SizedBox(height: 10),
                            const Text('O', style: TextStyle(color: Colors.black, fontSize: 16),),
                            const SizedBox(height: 10),
                            const _GoogleButton(),
                            const Spacer(),
                            const Text('¿No tienes una cuenta?', style: TextStyle(fontSize: 18)),
                            Text('Crear una cuenta', style: TextStyle(fontSize: 18, color: AppTheme.light, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppTheme.secondary ),)     
                          ]
                        ),
                      ),
                      
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




  void _handleGoogleSignIn() {
    // Implementa la lógica de inicio de sesión con Google aquí
    // Puedes usar un paquete como google_sign_in para facilitar la autenticación con Google
  }
}

class EmailLoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login con Correo y Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica de inicio de sesión con correo y contraseña
                _handleEmailSignIn();
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleEmailSignIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Realiza la validación de los campos
    if (email.isEmpty || password.isEmpty) {
      // Muestra un mensaje de error o realiza la lógica que desees
      return;
    }

    // Aquí puedes realizar la lógica de inicio de sesión con correo y contraseña
    // Por ejemplo, puedes llamar a un servicio de autenticación o validar en una base de datos

    // Después de realizar la lógica de inicio de sesión, puedes navegar a otra pantalla si es necesario
  }
}


class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black)
      ),
      child: Row(
        children: [
          Image.asset('assets/images/google.png',fit: BoxFit.fitHeight, height: 30,),
          const SizedBox(width: 10),
          const Expanded(child: Text('Con una cuenta de Google', style: TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}
