import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  static show({
    String? status,
    bool isSuccess = false,
    bool isFailure = false,
  }) {
    if (isSuccess) {
      return EasyLoading.showSuccess(
        status.toString(),
      );
    }
    if (isFailure) {
      return EasyLoading.showError(
        status.toString(),
      );
    }
    return EasyLoading.show();
  }
}
