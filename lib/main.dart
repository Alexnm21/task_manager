import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/config/routes.dart';
import 'package:task_manager/controllers/controllers.dart';
import 'package:task_manager/ui/screens/home/home_screen.dart';
import 'package:task_manager/data/repositories/user_repository.dart';
import 'package:task_manager/ui/screens/login/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //CAMBIAR LA PRESISTENCIA PARA QUE LA SESION SE GUARDE INCLUSO CUANDO SE CIERRE LA APP
  //await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  UserController userCtrl = Get.put(UserController());
  FirebaseAuth auth = FirebaseAuth.instance;
  if(auth.currentUser != null){
    userCtrl.user.value = await UserRepository().getUserByUid(auth.currentUser!.uid);
  }
  
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: FirebaseAuth.instance.currentUser != null ? const HomeScreen() : const LoginScreen(),
      theme: ThemeData.dark().copyWith(primaryColor: AppTheme.primary),
      getPages: Routes().routes,
    );
  }
}