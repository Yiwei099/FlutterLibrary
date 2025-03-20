
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var count = 1.obs;
  var title = ''.obs;

  final _titleArr = ['','授权','个人中心'];

  void changeIndex(int index) {
    currentIndex.value = index;
    title.value = _titleArr[index];
  }
}