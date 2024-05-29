import 'package:get/get.dart';
import 'package:sorting_visualizer/app/data/models/dto/response.dart';
import 'package:sorting_visualizer/app/data/models/request/auth_request.dart';
import 'package:sorting_visualizer/app/data/repository/user_repository.dart';
import 'package:sorting_visualizer/app/data/values/strings.dart';
import 'package:sorting_visualizer/app/routes/app_pages.dart';
import 'package:sorting_visualizer/base/base_controller.dart';
import 'package:sorting_visualizer/utils/helper/text_field_wrapper.dart';
import 'package:sorting_visualizer/utils/helper/validators.dart';
import 'package:sorting_visualizer/utils/loading/loading_utils.dart';

class AuthLoginController extends BaseController<UserRepository> {
  final mobileWrapper = TextFieldWrapper();

  sendOTP() async {
    String mobile = mobileWrapper.controller.text.trim();
    if (mobile.isValidPhone()) {
      mobileWrapper.errorText = Strings.empty;
    } else {
      mobileWrapper.errorText = ErrorMessages.invalidPhone;
      return;
    }

    LoadingUtils.showLoader();
    RepoResponse<bool> response =
        await repository.sendOTP(SendOTPRequest(phone: mobile));
    LoadingUtils.hideLoader();

    if (response.data ?? false) {
      Get.toNamed(Routes.AUTH_VERIFY_OTP, arguments: mobile);
    } else {
      mobileWrapper.errorText = response.error?.message ?? "";
    }
  }
}
