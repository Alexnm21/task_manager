import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<String> title = 'Iniciar Sesión'.obs;
  Rx<String> errorText = ''.obs;

  Rx<bool> loginForm = true.obs;
  Rx<bool> registerForm = false.obs;

  void switchLoginForm () async {
    if(loginForm.isTrue) {
      showRegisterForm();
    } else {
      showLoginForm();
    }
  }

  void showRegisterForm () async {
    loginForm.value = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    registerForm.value = true;
    title.value = 'Crear una Cuenta';
  }

  void showLoginForm () async {
    registerForm.value = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    loginForm.value = true;
    title.value = 'Iniciar Sesión';
  }

}