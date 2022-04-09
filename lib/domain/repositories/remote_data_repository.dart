import 'package:stipra/data/enums/change_password_action_type.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/domain/entities/barcode_timestamp.dart';
import 'package:stipra/domain/entities/user.dart';

import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class RemoteDataRepository {
  Future<List<OfferModel>> getOffers();

  Future<List<ProductModel>> getProducts();

  Future<void> sendBarcode(
      String barcode, String videoName, double latitude, double longitude);

  Future<bool> sendScannedVideo(
      String videoPath, double latitude, double longitude);

  Future<bool> callPythonForScannedVideo(
      String videoPath, double latitude, double longitude);

  Future<UserModel> login(
      String emailAddress, String password, bool? stayLoggedIn, String geo);

  Future<UserModel> register(
      String emailAddress,
      String password,
      String name,
      String mobile,
      String countrycode,
      bool? stayLoggedIn,
      double latitude,
      double longitude);

  Future<bool> smsConfirm(
    SmsActionType action,
    String emailAddress,
    String userId,
  );
  Future<String> resetPassword(
      ResetPasswordActionType action, String emailAddress,
      {String? password});

  Future<String> changePassword(
      ChangePasswordActionType action, String emailAddress, String userId,
      {String? newpassword});
}
