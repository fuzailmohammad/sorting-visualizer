import 'package:sorting_visualizer/app/data/models/response/app_config_response.dart';
import 'package:sorting_visualizer/app/data/values/urls.dart';
import 'package:sorting_visualizer/base/base_repository.dart';
import 'package:sorting_visualizer/utils/helper/exception_handler.dart';
import 'package:sorting_visualizer/utils/storage/storage_utils.dart';

class ConfigRepository extends BaseRepository {
  saveAppConfig() async {
    final response = await controller.get(path: URLs.appConfig);
    if (!(response is APIException))
      Storage.setAppConfig(AppConfigResponse.fromJson(response).data);
  }
}
