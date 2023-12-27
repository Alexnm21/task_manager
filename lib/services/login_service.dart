import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/controllers.dart';


class LoginService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserController userCtrl = Get.find();

  Future<User?> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // El usuario se crea con éxito
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print("Error al crear el usuario: $e");
      return null;
    }
  }
}