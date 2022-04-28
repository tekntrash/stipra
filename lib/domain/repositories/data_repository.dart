import 'package:dartz/dartz.dart';
import 'package:stipra/domain/entities/my_trade.dart';
import 'package:stipra/domain/entities/search_dto.dart';
import 'package:stipra/domain/entities/win_item.dart';
import '../../data/enums/change_email_action_type.dart';
import '../../data/enums/change_password_action_type.dart';
import '../../data/enums/reset_password_action_type.dart';
import '../../data/enums/sms_action_type.dart';
import '../../data/enums/trade_point_category.dart';
import '../../data/enums/win_point_category.dart';
import '../entities/profile.dart';
import '../entities/trade_item.dart';
import '../entities/user.dart';

import '../../core/errors/failure.dart';
import '../../data/enums/change_profile_action_type.dart';
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

  Future<Either<Failure, bool>> changeProfilePicture(String imagePath);

  Future<Either<Failure, String>> changeEmail(
    ChangeEmailActionType action,
    String emailAddress,
    String userId,
    String newEmail,
  );

  Future<Either<Failure, Profile>> changeProfile(
      ChangeProfileActionType action, dynamic profile);

  Future<Either<Failure, List<TradeItem>>> getTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
    bool expired,
  );
  Future<Either<Failure, List<WinItem>>> getWinPoints(WinPointCategory category,
      WinPointDirection direction, bool expired, List<double> coordinates);

  Future<Either<Failure, SearchDto>> search(String text);

  Future<Either<Failure, void>> sendMail(
      String name, String email, String content);

  Future<Either<Failure, String>> getPoints();

  Future<Either<Failure, String>> tradePoints(int perkId, int amount);

  Future<Either<Failure, List<MyTrade>>> getMyTrades();
}
