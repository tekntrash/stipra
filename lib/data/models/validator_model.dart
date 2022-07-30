import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ValidatorModel {
  late TextEditingController textController;
  late ValueNotifier<String?> errorNotifier;
  late Function() validate;
  ValidatorModel({
    String? initialText,
    Function()? validator,
  }) {
    if (validator == null) {
      validate = isEmpty;
    } else {
      validate = validator;
    }
    textController = TextEditingController(text: initialText);
    errorNotifier = ValueNotifier(null);
  }

  bool isEmpty() {
    if (textController.text.isEmpty) {
      errorNotifier.value = 'text_field_error_message'.tr;
      return false;
    }
    errorNotifier.value = null;
    return true;
  }
}
