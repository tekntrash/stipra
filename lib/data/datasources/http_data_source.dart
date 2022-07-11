import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/core/services/notification_service.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_router.dart';
import 'package:stipra/data/enums/my_product_category.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import 'package:stipra/data/models/food_fact_model.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/product_consumed_model.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/domain/entities/search_dto.dart';
import 'package:stipra/presentation/widgets/snackbar_show.dart';
import '../enums/change_email_action_type.dart';
import '../enums/change_password_action_type.dart';
import '../enums/change_profile_action_type.dart';
import '../enums/reset_password_action_type.dart';
import '../enums/sms_action_type.dart';
import '../enums/trade_point_category.dart';
import '../models/profile_model.dart';

import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

/// Remote data source
/// Using for handle HTTP requests with [RestApiPackage]

class HttpDataSource implements RemoteDataRepository {
  final baseUrl = 'https://api.stipra.com/';

  @override
  Future<List<OfferModel>> getOffers() {
    // TODO: implement getOffers
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  /// Uses for sending barcode to backend via HTTP [GET] request
  /// Send a request to [newapp/barcode.php] with
  /// [barcode] [videoName] [latitude] [longitude] parameters
  @override
  Future<void> sendBarcode(String barcode, String barcodeTimestamp,
      String videoName, double latitude, double longitude) async {
    final _timeStamp = int.parse(barcodeTimestamp) ~/ 1000;

    final result = await locator<RestApiHttpService>().request(
      RestApiRequest(
          endPoint: baseUrl + 'newapp/barcode.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'b': barcode,
            'v':
                'Latitude:$latitude,Longitude:$longitude^${videoName.split('/').last}',
            'g': '$latitude,$longitude',
            'i': locator<LocalDataRepository>().getUser().userid,
            't': _timeStamp,
          }),
      removeBaseUrl: true,
    );
    log('sendBarcode result: $result');
  }

  /// Uses for sending video to backend via HTTP [POST] request
  /// Send a request to [newapp/upload.php] with
  /// [videoPath] [latitude] [longitude] parameters
  /// Also calls [callPythonForScannedVideo] method when upload done
  /// It is return 'true' if upload done successfully
  /// Otherwise it is throw [Exception]
  @override
  Future<bool> sendScannedVideo(
    String videoPath,
    String videoDate,
    double latitude,
    double longitude, {
    dynamic cancelToken,
    ValueNotifier<double>? progressNotifier,
  }) async {
    var file = File(videoPath);
    log('sendScannedVideo token: ${locator<NotificationService>().token}');
    final result = await locator<RestApiHttpService>().requestFile(
      RestApiRequest(
        endPoint: baseUrl + 'newapp/upload.php',
        requestMethod: RequestMethod.POST,
        body: {
          'video-filename':
              'Latitude:$latitude,Longitude:$longitude^${file.path.split('/').last}',
          'submit': '',
          'videodate': '$videoDate',
          'token': locator<NotificationService>().token ?? '',
        },
      ),
      fileFieldName: 'fileToUpload',
      file: file,
      onSendProgress: (int sent, int total) {
        if (progressNotifier != null) {
          progressNotifier.value = (sent / total) * 100;
        }
        log('onSendProgress: $sent/$total');
      },
      cancelToken: cancelToken,
    );
    if (result.data != null && result.data.toString().contains('Saved file')) {
      log('sendScannedVideo result: $result');
      callPythonForScannedVideo(videoPath, videoDate, latitude, longitude);
      throw ServerFailure(errorMessage: 'Success but failed for test.');
      return true;
    } else {
      if (isDebugMode) {
        SnackbarShow.showAndClear(
            AppRouter().mainNavigatorKey!.currentState!.context,
            'Error: ${result.data}');
      }
      throw ServerFailure(errorMessage: 'Error: ${result.data}');
    }
  }

  /// Uses for sending credentials for login to backend via HTTP [POST] request
  /// Send a request to [newapp/login.php] with
  /// [emailAddress] [password] [stayLoggedIn] [geo] parameters
  /// If response is '{'status':'logged'}' then return [UserModel]
  /// If response is '{'status':'Needs confirming mobile'}' then throw [PhoneVerifyFailure]
  /// Otherwise it is throw [ServerException]
  @override
  Future<UserModel> login(String emailAddress, String password,
      bool? stayLoggedIn, String geo) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
            endPoint: baseUrl + 'newapp/login.php',
            requestMethod: RequestMethod.POST,
            body: {
              'email': emailAddress,
              'password': password,
              'geo': geo,
              'stayloggedin': (stayLoggedIn == true) ? 'on' : 'off',
              'submit': 'Login',
              'login': 'on',
            }),
      );
      Map<String, dynamic> result = json.decode(response.data);

      final status = result['status'];
      if (status == 'logged') {
        final userModel =
            locator<RestApiHttpService>().handleResponse<UserModel>(
          response,
          parseModel: UserModel(),
          isRawJson: true,
        );
        return userModel;
      } else {
        if (status == 'Incorrect login data') {
          throw ServerFailure(
              errorMessage: 'Some credentials are wrong, please try again.');
        } else if (status == 'Needs confirming mobile') {
          final userModel =
              locator<RestApiHttpService>().handleResponse<UserModel>(
            response,
            parseModel: UserModel(),
            isRawJson: true,
          );
          throw PhoneVerifyFailure(
            errorMessage:
                'You need to confirm your mobile number. Click here to confirm, we will send another code to your number.',
            userModel: userModel,
          );
        }
        throw ServerFailure(errorMessage: 'Error in registration');
      }
    } on ServerFailure catch (e) {
      log('e : $e');
      throw e;
    } on PhoneVerifyFailure catch (e) {
      log('e : $e');
      throw e;
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  /// Uses for sending credentials for register to backend via HTTP [POST] request
  /// Send a request to [newapp/register.php] with
  /// [emailAddress] [password] [name] [mobile] [countrycode] [stayLoggedIn] [latitude] [longitude] parameters
  /// If response is '{'status':'registered'}' then return [UserModel]
  /// Otherwise it is throw [ServerException]
  @override
  Future<UserModel> register(
    String emailAddress,
    String password,
    String name,
    String mobile,
    String countrycode,
    bool? stayLoggedIn,
    double latitude,
    double longitude,
  ) async {
    try {
      final ipAddress = await Ipify.ipv4();
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
            endPoint: baseUrl + 'newapp/register.php',
            requestMethod: RequestMethod.POST,
            body: {
              'email': emailAddress,
              'password': password,
              'geo':
                  'Latitude: ${latitude.toString()},Longitude: ${longitude.toString()}',
              'submit': 'Register',
              'register': 'on',
              'mobileno': mobile.replaceFirst(countrycode, ''),
              'countrycode': countrycode,
              'ip': '$ipAddress',
              'name': name,
            }),
      );
      log('register response: $response');
      Map<String, dynamic> result = json.decode(response.data);

      final status = result['status'];
      if (status == 'registered') {
        final userModel =
            locator<RestApiHttpService>().handleResponse<UserModel>(
          response,
          parseModel: UserModel(),
          isRawJson: true,
        );
        return userModel;
      } else {
        if (status == 'already registered') {
          throw ServerFailure(errorMessage: 'User already registered');
        }
        throw ServerFailure(errorMessage: 'Error in registration');
      }
    } on ServerFailure catch (e) {
      log('e : $e');
      throw e;
    } on PhoneVerifyFailure catch (e) {
      log('e : $e');
      throw e;
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  /// Uses for confirming otp and sending sms to phone via HTTP [GET] request
  /// Send a request to [newapp/sms.php] with
  /// [action] [emailAddres] [userId] parameters
  /// If response is '{'status':'verified'}' then return true
  /// If response is '{'status':'SMS sent'}' then return true
  /// If response is '{'status':'Email sent'}' then return true
  /// If response is '{'status':'Tries exceeded'}' then return [PhoneSmsExceededLimit]
  /// Otherwise it is throw [ServerException]
  @override
  Future<bool> smsConfirm(
    SmsActionType action,
    String emailAddres,
    String userId,
  ) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
            endPoint: baseUrl + 'newapp/sms.php',
            requestMethod: RequestMethod.GET,
            queryParameters: {
              'action': action.name,
              'alogin': emailAddres,
              'userid': userId,
            }),
      );
      log('Response: $response');
      log('QP: ${response.requestOptions.queryParameters}');
      Map<String, dynamic> result = json.decode(response.data);
      log('Response 2: $result');
      final status = result['status'];
      if (status == 'verified' ||
          status == 'SMS sent' ||
          status == 'Email sent') {
        return true;
      } else {
        if (status == 'Tries exceeded') {
          //Mmm...This is not working. Please send an email to info@stipra.com and we will sort it out. Sorry about this.
          throw PhoneSmsExceededLimit(
              errorMessage:
                  'Mmm... This is not working. Click here and we will send you an email instead.');
        } else if (status == 'User not found') {
          throw ServerFailure(
              errorMessage: 'Some credentials are wrong, please try again.');
        } else if (status == 'Receivers number are invalid') {
          throw ServerFailure(
              errorMessage: 'The phone number you entered is invalid.');
        }
        throw ServerFailure(errorMessage: 'Error in confirmation.');
      }
    } on ServerFailure catch (e) {
      log('e sf: $e');
      throw e;
    } on PhoneVerifyFailure catch (e) {
      log('e pvf: $e');
      throw e;
    } on PhoneSmsExceededLimit catch (e) {
      log('e pse : $e');
      throw e;
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  /// Uses for sending barcode to backend via HTTP [GET] request
  /// Send a request to [newapp/resetpassword.php] with
  /// [action] [emailAddres] [password] parameters
  /// If response is '{'status':'verified'}' then return otp
  /// If response is '{'status':'SMS sent'}' then return otp
  /// If response is '{'status':'Email sent'}' then return otp
  /// If response is '{'status':'password changed'}' then return otp
  /// If response is '{'status':'Tries exceeded'}' then return [PhoneSmsExceededLimit]
  /// Otherwise it is throw [ServerException]
  @override
  Future<String> resetPassword(
    ResetPasswordActionType action,
    String emailAddres, {
    String? password,
  }) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
            endPoint: baseUrl + 'newapp/resetpassword.php',
            requestMethod: RequestMethod.GET,
            queryParameters: {
              'action': action.name,
              'email': emailAddres,
              'password': password,
            }),
      );
      log('Response resetpassword: $response');
      log('QP: ${response.requestOptions.queryParameters}');
      Map<String, dynamic> result = json.decode(response.data);
      log('Response resetpassword 2: $result');
      final status = result['status'];
      //final code = result['code'];
      if (status == 'verified' ||
          status == 'SMS sent' ||
          status == 'password changed' ||
          status == 'Email sent') {
        return result['otp'] ?? '';
      } else {
        if (status == 'Tries exceeded') {
          throw PhoneSmsExceededLimit(
              errorMessage:
                  'Mmm... This is not working. Click here and we will send you an email instead.');
        } else if (status == 'User not found') {
          throw ServerFailure(
              errorMessage: 'Email is not registered, please try again.');
        } else if (status == 'password not changed') {
          throw ServerFailure(
              errorMessage: 'Password didn\'t change, please try again.');
        }
        throw ServerFailure(errorMessage: 'Error in confirmation.');
      }
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  @override
  Future<String> changePassword(
    ChangePasswordActionType action,
    String emailAddress,
    String userId, {
    String? oldpassword,
    String? newpassword,
  }) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/changepassword.php',
          requestMethod: RequestMethod.POST,
          queryParameters: {
            'action': action.name,
            'userid': userId,
            'alogin': emailAddress,
          },
          body: {
            'oldpassword': oldpassword,
            'newpassword': newpassword,
          },
        ),
      );
      log('Response changePassword: $response');
      log('QP: ${response.requestOptions.queryParameters}');
      Map<String, dynamic> result = json.decode(response.data);
      log('Response changePassword 2: $result');
      final status = result['status'];
      if (status == 'password changed') {
        return 'success';
      } else {
        if (status == 'password mismatch') {
          throw ServerFailure(
              errorMessage:
                  'The old password you entered is incorrect, check it and try again.');
        } else if (status == 'User not found') {
          throw ServerFailure(
              errorMessage: 'Email is not registered, please try again.');
        } else if (status == 'password not changed') {
          throw ServerFailure(
              errorMessage: 'Password didn\'t change, please try again.');
        } else if (status == 'No email') {
          throw ServerFailure(
              errorMessage:
                  'We couldn\'t find your account, please try again.');
        }
        throw ServerFailure(errorMessage: 'Error in confirmation.');
      }
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  @override
  Future<bool> callPythonForScannedVideo(String videoPath, String videoDate,
      double latitude, double longitude) async {
    log('SAVE.PHP   videodate: $videoDate');
    final result = await locator<RestApiHttpService>().requestForm(
      RestApiRequest(
        endPoint: baseUrl + 'newapp/save.php',
        requestMethod: RequestMethod.POST,
        queryParameters: {
          'filename':
              'Latitude:$latitude,Longitude:$longitude^${videoPath.split('/').last}',
          'alogin': locator<LocalDataRepository>().getUser().alogin,
          'submit': '',
        },
        body: {
          'videodate': '$videoDate',
        },
      ),
    );
    if (result.data != null && result.data.toString().contains('Saved file')) {
      return true;
    } else {
      throw ServerFailure(errorMessage: result.data);
    }
  }

  @override
  Future<bool> changeProfilePicture(String imagePath) async {
    var file = File(imagePath);

    final result = await locator<RestApiHttpService>().requestFile(
      RestApiRequest(
        endPoint: baseUrl + 'newapp/savepic.php',
        requestMethod: RequestMethod.POST,
        queryParameters: {
          'alogin': locator<LocalDataRepository>().getUser().alogin,
          'userid': locator<LocalDataRepository>().getUser().userid,
          'submit': '',
        },
        body: {
          'submit': '',
        },
      ),
      fileFieldName: 'fileToUpload',
      file: file,
      onSendProgress: (int sent, int total) {
        log('onSendProgress: $sent/$total');
      },
    );

    log('changeProfilePicture result: $result');
    if (result.data != null && result.data.toString().contains('File saved')) {
      log('change profile pic result: $result');
      return true;
    } else {
      throw ServerFailure(errorMessage: result.data);
    }
  }

  @override
  Future<String> changeEmail(
    ChangeEmailActionType action,
    String emailAddress,
    String userId,
    String newEmail,
  ) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/changeemail.php',
          requestMethod: RequestMethod.POST,
          queryParameters: {
            'action': action.name,
            'userid': userId,
            'alogin': emailAddress,
            'newemail': newEmail,
          },
        ),
      );
      log('Response changeEmail: $response');
      log('QP: ${response.requestOptions.queryParameters}');
      Map<String, dynamic> result = json.decode(response.data);
      log('Response changeEmail 2: $result');
      final status = result['status'];
      if (status == 'email changed') {
        return 'success';
      } else {
        if (status == 'Email sent' && result['otp'] != null) {
          throw EmailVerifyFailure(
            errorMessage:
                'You need to confirm your new email address. We will send code to your new email address.',
            otp: '${result['otp']}',
          );
        } else if (status == 'User not found') {
          throw ServerFailure(
              errorMessage: 'Email is not registered, please try again.');
        } else if (status == 'password not changed') {
          throw ServerFailure(
              errorMessage: 'Password didn\'t change, please try again.');
        } else if (status == 'No email') {
          throw ServerFailure(
              errorMessage:
                  'We couldn\'t find your account, please try again.');
        }
        throw ServerFailure(errorMessage: 'Error in confirmation.');
      }
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  @override
  Future<ProfileModel> changeProfile(
    ChangeProfileActionType action,
    dynamic profile,
  ) async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      log('Requesting changeProfile and tthe profile is: ${profile?.toJson()}');
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/changeprofile.php',
          requestMethod: RequestMethod.POST,
          queryParameters: {
            'action': action.name,
            'userid': user.userid,
            'alogin': user.alogin,
          },
          body: profile?.toJson() ?? {},
        ),
      );
      log('Response of request changeProfile: $response');
      final profileModel =
          locator<RestApiHttpService>().handleResponse<ProfileModel>(
        response,
        parseModel: ProfileModel(),
        isRawJson: true,
      );
      Map<String, dynamic> result = json.decode(response.data);

      final status = result['status'];
      if (status == 'No zipcode') {
        throw ServerFailure(errorMessage: 'Please input a zipcode to process.');
      } else {
        return profileModel;
      }
    } catch (e) {
      log('e : $e');
      throw e;
    }
  }

  @override
  Future<List<TradeItemModel>> getTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
    bool expired,
  ) async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<TradeItemModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/tradepoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'show',
            'category': category.index,
            'direction': direction.name,
            'includeexpired': expired ? 'yes' : 'no',
          },
        ),
        parseModel: TradeItemModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<WinItemModel>> getWinPoints(
      WinPointCategory category,
      WinPointDirection direction,
      bool expired,
      bool outsideGeo,
      List<double> coordinates) async {
    log('Outside geo: $outsideGeo');
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<WinItemModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/winpoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'show',
            'category': category.index,
            'direction': direction.name,
            'includeexpired': expired ? 'yes' : 'no',
            if (outsideGeo) 'includeoutsidegeo': outsideGeo ? 'yes' : 'no',
            'latitude': coordinates[0],
            'longitude': coordinates[1],
          },
        ),
        parseModel: WinItemModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<SearchDtoModel> search(
    String text,
  ) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/search.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'search',
            'text': text,
            'direction': 'asc',
            'order': '1',
            'category': '0',
          },
        ),
      );
      log('Response of request search: $response');
      final result =
          locator<RestApiHttpService>().handleResponse<SearchDtoModel>(
        response,
        parseModel: SearchDtoModel(),
        isRawJson: true,
      );
      return result;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> sendMail(String name, String email, String content) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/contact.php',
          requestMethod: RequestMethod.POST,
          queryParameters: {
            'action': 'sendemail',
          },
          body: {
            'name': name,
            'email': email,
            'content': content,
          },
        ),
      );
      log('Response of request send email: $response');
      Map<String, dynamic> result = json.decode(response.data);
      final status = result['status'];
      if (status == 'Email sent') {
        return;
      } else {
        throw status ?? 'Unknown error';
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<String> getPoints() async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/points.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'getpoints',
            'userid': user.userid,
          },
        ),
      );
      log('Response of request get points: $response');
      List result = json.decode(response.data);
      final points = result[0]['points'];
      if (points != null) {
        user.points = '$points';
        await user.save();
        return '$points';
      } else {
        throw 'Can not get points';
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<String> tradePoints(int perkId, int amount) async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/tradepoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'trade',
            'userid': user.userid,
            'alogin': user.alogin,
            'amount': amount,
            'id': perkId,
          },
        ),
      );
      log('Response of request trade points: $response');
      Map<String, dynamic> result = json.decode(response.data);
      final status = result['status'];
      if (status != null && status.contains('Traded ')) {
        return status;
      } else if (status != null) {
        throw status;
      } else {
        throw 'Can not trade points please try again.';
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<MyTradeModel>> getMyTrades() async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<MyTradeModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/tradepoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'showtrades',
            'userid': user.userid,
          },
        ),
        parseModel: MyTradeModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<ProductConsumedModel>> getProductsConsumed(
      MyProductOrder order, MyProductDirection direction) async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<ProductConsumedModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/products.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'showproducts',
            'userid': user.userid,
            'order': order.name,
            'direction': direction.name,
            'excludeunknown': 'yes',
          },
        ),
        parseModel: ProductConsumedModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteAccount(String password) async {
    try {
      final user = locator<LocalDataRepository>().getUser();
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/deleteprofile.php',
          requestMethod: RequestMethod.POST,
          queryParameters: {
            'action': 'deleteprofile',
            'userid': user.userid,
            'alogin': user.alogin,
          },
          body: {
            'password': '$password',
          },
        ),
      );

      Map<String, dynamic> result = json.decode(response.data);
      final status = result['status'];
      if (status != null && status.contains('deleted')) {
        return;
      } else if (status != null) {
        if (status == 'Password incorrect') {
          throw 'The password you entered is incorrect.';
        }
        throw status;
      } else {
        throw 'Can not delete profile, please try again.';
      }
      log('request of delete: ${response.requestOptions.queryParameters}');
      log('Response of delete: ${response}');

      return;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<FoodFactModel> getFoodFact(String barcode) async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandle<FoodFactModel>(
        RestApiRequest(
          endPoint:
              'https://world.openfoodfacts.org/api/v0/product/$barcode.json',
          requestMethod: RequestMethod.GET,
          queryParameters: {},
        ),
        parseModel: FoodFactModel(),
        isRawJson: false,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> isVideoAlreadyUploaded(String path, String creationDate) async {
    try {
      final response = await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/checkfiles.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'checkfiles',
            'alogin': '${locator<LocalDataRepository>().getUser().alogin}',
            'userid': '${locator<LocalDataRepository>().getUser().userid}',
            'filename': '$path',
          },
        ),
      );
      if (response.data.contains('not found')) {
        return false;
      }
      return true;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<WinItemModel>> getWinPointsFeatured() async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<WinItemModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/winpoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'show',
            'onlyfeatured': 'yes',
          },
        ),
        parseModel: WinItemModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> addSeenWinPoint(String id) async {
    try {
      await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/winpoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'update',
            'id': id,
          },
        ),
      );

      return;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<TradeItemModel>> getTradePointsFeatured() async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandleList<TradeItemModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/tradepoints.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'show',
            'onlyfeatured': 'yes',
          },
        ),
        parseModel: TradeItemModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> saveFCMToken(String token) async {
    try {
      await locator<RestApiHttpService>().requestForm(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/fcm.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'save',
            'token': token,
          },
        ),
      );

      return;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<SearchDto> getFeatured(double lat, double long) async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestFormAndHandle<SearchDtoModel>(
        RestApiRequest(
          endPoint: baseUrl + 'newapp/featured.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'action': 'show',
            'latitude': lat,
            'longitude': long,
          },
        ),
        parseModel: SearchDtoModel(),
        isRawJson: true,
      );

      return response;
    } catch (e) {
      log('Error in getFeatured : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }
}
