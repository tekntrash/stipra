import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AutoValidatorModel {
  late TextEditingController textController;
  late String? Function(String?) validate;
  AutoValidatorModel({
    String? initialText,
    String? Function(String?)? validator,
  }) {
    if (validator == null) {
      validate = _isEmpty;
    } else {
      validate = validator;
    }
    textController = TextEditingController(text: initialText);
  }

  String? _isEmpty(String? text) {
    if (text?.isEmpty == true) {
      return 'text_field_error_message'.tr;
    }
    return null;
  }
}
