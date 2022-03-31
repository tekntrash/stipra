import 'dart:developer';
import 'dart:io';

import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/domain/repositories/remote_data_repository.dart';
import 'package:stipra/injection_container.dart';

import '../../core/errors/exception.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';

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
    final result = await RespApiHttpService().request(
      RestApiRequest(
          endPoint: baseUrl + 'barcode.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'b': barcode,
            'v': videoName,
            'g': '$latitude,$longitude',
          }),
      removeBaseUrl: true,
    );
    log('sendBarcode result: $result');
  }

  @override
  Future<bool> sendScannedVideo(String videoPath) async {
    var file = File(videoPath);

    final result = await RespApiHttpService().requestFile(
      RestApiRequest(
        endPoint: baseUrl + 'upload.php',
        requestMethod: RequestMethod.POST,
        body: {
          'video-filename': file.path.split('/').last,
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
      return true;
    } else {
      throw ServerException();
    }
  }
}
