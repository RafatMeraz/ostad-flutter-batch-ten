import 'package:get/get.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.loginUrl, body: requestBody, isFromLogin: true
    );
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}