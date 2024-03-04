import 'package:get/get.dart';

class HomeController extends GetxController{
  Rx<double> xOffset = 0.0.obs;
  Rx<double> yOffset = 0.0.obs;

  Rx<bool> isDrawerOpen = false.obs;

  openDrawer(){
    isDrawerOpen.value = true;
    xOffset.value = 290;
    yOffset.value = 80;
  }

  closeDrawer(){
    isDrawerOpen.value = false;
    xOffset.value = 0;
    yOffset.value = 0;
  }
}