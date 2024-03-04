import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/controllers.dart';
import 'package:task_manager/data/repositories/user_repository.dart';


class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserController userCtrl = Get.find();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<String> createUser({required String email, required String password, required String name}) async {
    try {
      // Verificar si el correo electrónico ya existe
      QuerySnapshot existingUsers = await usersCollection.where('email', isEqualTo: email).get();
      if (existingUsers.docs.isNotEmpty) {
        // El correo electrónico ya está en uso, puedes manejar esto de la manera que desees
        return 'El correo electrónico ya está registrado';
      }

      // Crear el usuario en Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user == null) {
        throw Exception('Error al crear la cuenta, vuelva a intentarlo más tarde');
      }

      // Guardar información adicional en la colección de usuarios
      await usersCollection.doc(user.uid).set({
        'email': email,
        'name': name,
        'uid': user.uid
      });

      return ''; // Indicar que la creación fue exitosa
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email,password: password,);

      userCtrl.user.value = await UserRepository().getUserByUid(auth.currentUser!.uid);
      // Usuario autenticado con éxito
      return '';
    } catch (e) {
      // Error durante el inicio de sesión
      return 'Error durante el inicio de sesión: $e';
    }
  }
}