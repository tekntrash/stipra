import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/auto_validator_model.dart';

import '../../../../core/services/validator_service.dart';

class LoyaltyCardAddViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cardIssuer = '';
}
