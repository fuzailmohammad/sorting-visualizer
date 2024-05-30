import 'package:get/get.dart';
import 'package:sorting_visualizer/app/routes/app_pages.dart';
import 'package:sorting_visualizer/utils/storage/storage_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startOnboarding();
  }

  _startOnboarding() async {
    await Future.delayed(Duration(seconds: 3));
      Get.offAllNamed(Routes.HOME);
  }
}
