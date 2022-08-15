import 'package:flutter/foundation.dart';
import 'package:stipra/data/enums/my_product_category.dart';
import 'package:stipra/data/models/food_fact_model.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/privacy_model.dart';
import 'package:stipra/data/models/product_consumed_model.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/domain/entities/search_dto.dart';

import '../../data/enums/change_email_action_type.dart';
import '../../data/enums/change_password_action_type.dart';
import '../../data/enums/reset_password_action_type.dart';
import '../../data/enums/sms_action_type.dart';
import '../../data/enums/trade_point_category.dart';
import '../../data/enums/win_point_category.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/trade_item_model.dart';
import '../../data/models/user_model.dart';

import '../../data/enums/change_profile_action_type.dart';
import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class RemoteDataRepository {
  Future<List<OfferModel>> getOffers();

  Future<List<ProductModel>> getProducts();

  Future<void> sendBarcode(String barcode, String barcodeTimestamp,
      String videoName, double latitude, double longitude);

  Future<bool> sendScannedVideo(
      String videoPath, String videoDate, double latitude, double longitude,
      {dynamic cancelToken, ValueNotifier<double>? progressNotifier});

  Future<bool> callPythonForScannedVideo(
      String videoPath, String videoDate, double latitude, double longitude);

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
    ChangePasswordActionType action,
    String emailAddress,
    String userId, {
    String? oldpassword,
    String? newpassword,
  });

  Future<bool> changeProfilePicture(String imagePath);

  Future<String> changeEmail(
    ChangeEmailActionType action,
    String emailAddress,
    String userId,
    String newEmail,
  );

  Future<ProfileModel> changeProfile(
      ChangeProfileActionType action, dynamic profile);

  Future<List<TradeItemModel>> getTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
    bool expired,
  );
  Future<List<WinItemModel>> getWinPoints(
      WinPointCategory category,
      WinPointDirection direction,
      bool expired,
      bool outsideGeo,
      List<double> coordinates);

  Future<SearchDtoModel> search(String text);

  Future<void> sendMail(
      String name, String email, String content, bool isDebug);

  Future<String> getPoints();

  Future<String> tradePoints(int perkId, int amount);

  Future<List<MyTradeModel>> getMyTrades();

  Future<List<ProductConsumedModel>> getProductsConsumed(
      MyProductOrder order, MyProductDirection direction);

  Future<void> deleteAccount(String password);

  Future<FoodFactModel> getFoodFact(String barcode);

  Future<bool> isVideoAlreadyUploaded(String path, String creationDate);

  Future<List<WinItemModel>> getWinPointsFeatured();

  Future<void> addSeenWinPoint(String id);
  Future<void> addSeenTradePoint(String id);

  Future<List<TradeItemModel>> getTradePointsFeatured();

  Future<void> saveFCMToken(String token);

  Future<SearchDto> getFeatured(double lat, double long);

  Future<PrivacyModel> getPrivacy();
  Future<PrivacyModel> setPrivacy(PrivacyModel privacyModel);
}
