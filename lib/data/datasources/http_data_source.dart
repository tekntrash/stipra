import 'dart:developer';

import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/domain/repositories/remote_data_repository.dart';

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
  Future<void> sendBarcode(String barcode) async {
    final result = await RespApiHttpService().request(
      RestApiRequest(
          endPoint: baseUrl + 'barcode.php',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            'b': barcode,
          }),
      removeBaseUrl: true,
    );
    log('result: $result');
  }
}
