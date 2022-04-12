import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/data/enums/change_password_action_type.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';

import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

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

  @override
  Future<void> sendBarcode(String barcode, String videoName, double latitude,
      double longitude) async {
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
          }),
      removeBaseUrl: true,
    );
    log('sendBarcode result: $result');
  }

  @override
  Future<bool> sendScannedVideo(
      String videoPath, double latitude, double longitude) async {
    var file = File(videoPath);

    final result = await locator<RestApiHttpService>().requestFile(
      RestApiRequest(
        endPoint: baseUrl + 'newapp/upload.php',
        requestMethod: RequestMethod.POST,
        body: {
          'video-filename':
              'Latitude:$latitude,Longitude:$longitude^${file.path.split('/').last}',
          'submit': '',
        },
      ),
      fileFieldName: 'fileToUpload',
      file: file,
      onSendProgress: (int sent, int total) {
        log('onSendProgress: $sent/$total');
      },
    );
    if (result.data != null && result.data.toString().contains('Saved file')) {
      log('sendScannedVideo result: $result');
      callPythonForScannedVideo(videoPath, latitude, longitude);
      return true;
    } else {
      throw ServerException();
    }
  }

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
  Future<bool> callPythonForScannedVideo(
      String videoPath, double latitude, double longitude) async {
    final result = await locator<RestApiHttpService>().requestForm(
      RestApiRequest(
        endPoint: baseUrl + 'newapp/save.php',
        requestMethod: RequestMethod.GET,
        queryParameters: {
          'filename':
              'Latitude:$latitude,Longitude:$longitude^${videoPath.split('/').last}',
          'alogin': locator<LocalDataRepository>().getUser().alogin,
          'submit': '',
        },
      ),
    );
    log('CallPythonForScannedVideo result: $result');
    if (result.data != null && result.data.toString().contains('Saved file')) {
      return true;
    } else {
      throw ServerException();
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
      log('sendScannedVideo result: $result');
      return true;
    } else {
      throw ServerException();
    }
  }
}
