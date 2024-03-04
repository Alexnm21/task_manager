import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/config/util.dart';
import 'package:task_manager/controllers/login_controller.dart';
import 'package:task_manager/data/repositories/login_repository.dart';
import 'package:task_manager/ui/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginCtrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light,
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
                _Title(loginCtrl: loginCtrl),
                const SizedBox(height: 40,),
                const Expanded(
                  child: Stack(
                    children: [
                      _RegisterForm(),
                      _LoginForm(),
                    ],
                  ),
                )
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.loginCtrl,
  });

  final LoginController loginCtrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return FadeInLeft(
          animate: loginCtrl.loginForm.value || loginCtrl.registerForm.value,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 0, left: 20),
            child: Text(loginCtrl.title.value, style: const TextStyle(color: Colors.white, fontSize: 40)),
          ),
        );
    },);
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    LoginController loginCtrl = Get.find();
    return Obx(
      ()=> SlideInUp(
        animate: loginCtrl.loginForm.value,
        from: Get.height,
        duration: const Duration(milliseconds: 1000),
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
                CustomTextField(labelText: 'Email', icon: Icon(Icons.alternate_email_outlined, color: AppTheme.iconColor), controller: TextEditingController()),
                const SizedBox(height: 20),
                CustomTextField(labelText: 'Contraseña', icon: Icon(Icons.lock_outline, color: AppTheme.iconColor), controller: TextEditingController()),
                const SizedBox(height: 30),
                const Text('¿Olvidaste la contraseña?', style: TextStyle(color: Colors.grey, fontSize: 16),),
                const Spacer(),
                SizedBox(width:200, child: CustomButton(text: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){}, gradient: LinearGradient(colors: [AppTheme.secondary, AppTheme.light]),)),
                const SizedBox(height: 10),
                const Text('O', style: TextStyle(color: Colors.black, fontSize: 16),),
                const SizedBox(height: 10),
                const _GoogleButton(),
                const Spacer(),
                const Text('¿No tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    loginCtrl.switchLoginForm();
                  },
                  child: Text('Crear una cuenta', style: TextStyle(fontSize: 18, color: AppTheme.light, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppTheme.secondary ),))     
              ]
            ),
          ),
          
        ),
      ),
    );
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
          const Expanded(child: Text('Con una cuenta de Google', style: TextStyle(fontSize: 18, color: Colors.grey), overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  static const double inputPadding = 20.0;

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final LoginController loginCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> FadeIn(
        duration: const Duration(milliseconds: 1000),
        animate: loginCtrl.registerForm.value,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //DIALOGOS DE TEXTO
              CustomTextField(hintText: 'Nombre',icon: Icon(Icons.person, color: AppTheme.iconColor,), controller: _nameController),
              CustomTextField(hintText: 'Correo Electrónico', controller: _emailController, keyboardType: TextInputType.emailAddress, icon: Icon(Icons.alternate_email, color: AppTheme.iconColor,)),
              CustomTextField(hintText: 'Contraseña', controller: _passwordController, icon: Icon(Icons.lock_outline, color: AppTheme.iconColor,), obscureText: true, onChanged: onChangedPassword,),
              CustomTextField(hintText: 'Repetir Contraseña', controller: _confirmPasswordController, icon: Icon(Icons.lock_outline, color: AppTheme.iconColor,), obscureText: true, onChanged: onChangedConfirmPassword,),

              // MENSAJE DE ERROR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(loginCtrl.errorText.value != '')
                  const Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.error_outline, color: Colors.redAccent,),),
                  Expanded(child: Text(loginCtrl.errorText.value, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis, ), maxLines: 2,)),
                ],
              ),
              const SizedBox(height: 32.0),
              CustomButton(text: Text('Crear Cuenta', style: TextStyle(color: AppTheme.primary, fontSize: 20),), onPressed: createAccount, color: const Color.fromARGB(255, 255, 255, 255),),
              const SizedBox(height: 32.0),

              const Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.white)),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {
                  loginCtrl.switchLoginForm();
                },
                child: const Text('Iniciar Sesión', style: TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.white, fontSize: 18,overflow: TextOverflow.ellipsis,), ),
                )
            ],
          ),
        ),
      ),
    );
  }

  onChangedConfirmPassword(String text){
    setState(() {
      if(text == _passwordController.text || text == '') {
        loginCtrl.errorText.value = '';
      } else {
        loginCtrl.errorText.value = 'Las contraseñas deben coincidir';
      }
    });
  }

  onChangedPassword(String text){
    if(checkSecurePassword(text)) {
      loginCtrl.errorText.value = '';
    }else{
      loginCtrl.errorText.value = 'La contraseña debe ser segura.';
    }
  }

  createAccount() async {
    print('boton crar');
    //Comprobar que todos los campos están completos
    if(!allTextFilled()) {
      loginCtrl.errorText.value = 'Debes llenar todos los campos para crear una cuenta.';
    }
    loginCtrl.errorText.value = await AuthRepository().createUser(email: _emailController.text, password: _passwordController.text, name: _nameController.text);
  }

  bool allTextFilled(){
    if(_nameController.text == '') return false;
    if(_emailController.text == '') return false;
    if(_passwordController.text == '') return false;
    if(_confirmPasswordController.text == '') return false;

    return true;
  }
}
