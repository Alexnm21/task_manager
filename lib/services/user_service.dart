import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/controllers.dart';
import 'package:task_manager/model/model.dart';


class UserService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserController userCtrl = Get.find();
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<String> createUser({required String email, required String password, required String name}) async {
    try {
      // Verificar si el correo electrónico ya existe
      QuerySnapshot existingUsers = await _usersCollection.where('email', isEqualTo: email).get();
      if (existingUsers.docs.isNotEmpty) {
        // El correo electrónico ya está en uso, puedes manejar esto de la manera que desees
        return 'El correo electrónico ya está registrado';
      }

      // Crear el usuario en Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // El usuario se crea con éxito
      User? user = userCredential.user;

      if (user == null) {
        throw Exception('Error al crear la cuenta, vuelva a intentarlo más tarde');
      }

      // Guardar información adicional en la colección de usuarios
      await _usersCollection.doc(user.uid).set({
        'email': email,
        'name': name,
        'uid': user.uid
      });

      return ''; // Indicar que la creación fue exitosa
    } catch (e) {
      return e.toString();
    }
  }

   Future<UserData?> getUserByUid(String uid) async {
    try {
      // Accede a la colección de usuarios y obtén el documento por el uid
      DocumentSnapshot userSnapshot = await _usersCollection.doc(uid).get();

      // Verifica si el documento existe
      if (userSnapshot.exists) {
        // Devuelve los datos del usuario como un mapa
        Map<String, dynamic> userMap = userSnapshot.data() as Map<String, dynamic>;
        return UserData.fromMap(userMap);
      } else {
        // Si el usuario no existe, devuelve null
        return null;
      }
    } catch (e) {
      // Maneja cualquier error que pueda ocurrir durante la operación
      print('Error al obtener el usuario: $e');
      return null;
    }
  }
}