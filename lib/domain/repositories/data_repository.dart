import 'package:dartz/dartz.dart';
import 'package:stipra/data/enums/change_password_action_type.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';
import 'package:stipra/domain/entities/user.dart';

import '../../core/errors/failure.dart';
import '../entities/offer.dart';
import '../entities/product.dart';

abstract class DataRepository {
  Future<Either<Failure, List<Offer>>> getOffers();

  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, void>> sendBarcode(
      String barcode, String videoName, double latitude, double longitude);

  Future<Either<Failure, bool>> sendScannedVideo(
      String videoPath, double latitude, double longitude);

  Future<Either<Failure, void>> callPythonForScannedVideo(
      String videoPath, double latitude, double longitude);

  Future<Either<Failure, User>> login(
      String emailAddress, String password, bool? stayLoggedIn, String geo);

  Future<Either<Failure, User>> register(
      String emailAddress,
      String password,
      String name,
      String mobile,
      String countrycode,
      bool? stayLoggedIn,
      double latitude,
      double longitude);

  Future<Either<Failure, bool>> smsConfirm(
    SmsActionType action,
    String emailAddress,
    String userId,
  );

  Future<Either<Failure, String>> resetPassword(
      ResetPasswordActionType action, String emailAddress,
      {String? password});

  Future<Either<Failure, String>> changePassword(
    ChangePasswordActionType action,
    String emailAddress,
    String userId, {
    String? oldpassword,
    String? newpassword,
  });
}
