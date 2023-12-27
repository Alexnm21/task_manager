import 'package:get/get.dart';
import 'package:task_manager/screens/screens.dart';
import 'package:task_manager/screens/singup_screen.dart';

class Routes {
  List<GetPage<dynamic>> routes = [
    GetPage(name: '/login', page: () => const LoginScreen(), transition: Transition.rightToLeft),
    GetPage(name: '/register', page: () => SignUpScreen(), transition: Transition.leftToRight),
    
  ];
}