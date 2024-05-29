import 'package:sorting_visualizer/app/data/repository/config_repository.dart';
import 'package:sorting_visualizer/base/base_controller.dart';

class AppController extends BaseController<ConfigRepository> {
  @override
  void onInit() {
    super.onInit();
    repository.saveAppConfig();
  }
}
