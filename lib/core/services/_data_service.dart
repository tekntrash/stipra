import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';

import '../../core/errors/failure.dart';
import '../../core/platform/network_info.dart';
import '../../injection_container.dart';

abstract class DataService {
  NetworkInfo get networkInfo => locator<NetworkInfo>();

  Future<DataModel<List<T>>> getDataList<T extends IRestApiBaseModel>({
    Future<void> Function(List<T>)? saveCache,
    Future<List<T>> Function()? getCache,
    IRestApiRequest? request,
    required T Function() parseModel,
    String? mockUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await callList(
          request!,
          parseModel,
          mockUrl,
        );
        return Right(remoteData);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else if (getCache != null) {
      try {
        final localData = await getCache();
        return Right(localData);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<DataModel<T>> getData<T extends IRestApiBaseModel>({
    Future<void> Function(T)? saveCache,
    Future<T> Function()? getCache,
    IRestApiRequest? request,
    required T Function() parseModel,
    String? mockUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await call(
          request!,
          parseModel,
          mockUrl,
        );
        return Right(remoteData);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else if (getCache != null) {
      try {
        final localData = await getCache();
        return Right(localData);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<List<T>> callList<T extends IRestApiBaseModel>(
    IRestApiRequest request,
    T Function() parseModel,
    String? mockUrl,
  ) async {
    if (mockUrl != null && environmentTag == DataType.mock) {
      return callMockList<T>(mockUrl, parseModel);
    } else {
      return callRemoteList<T>(request, parseModel);
    }
    throw Exception('Something went wrong with callList $T');
  }

  Future<T> call<T extends IRestApiBaseModel>(
    IRestApiRequest request,
    T Function() parseModel,
    String? mockUrl,
  ) async {
    if (mockUrl != null && environmentTag == DataType.mock) {
      return callMock<T>(mockUrl, parseModel);
    } else {
      return callRemote<T>(request, parseModel);
    }
    throw Exception('Something went wrong with call $T');
  }

  /*Future call<T>(
    IRestApiRequest request,
    T Function() parseModel,
  ) async {
    final isList = T.toString().startsWith('List<');
    if (dataSource == DataSource.HTTP) {
      if (T is List) {
        return callRemoteList<T>(request, parseModel);
      } else {
        return callRemote<T>(request, parseModel);
      }
    } else if (dataSource == DataSource.MOCK) {
      print('T = ${T.toString()} isList? $isList');
      if (isList) {
        return callMockList<T>('test/mocks/home_campaigns.json', parseModel);
      } else {
        return callMock<T>('test/mocks/home_campaigns.json', parseModel);
      }
    } else {
      throw 'e';
    }
  }*/

  Future<T> callRemote<T extends IRestApiBaseModel>(
      IRestApiRequest request, T Function() creator) async {
    try {
      return locator<RestApiHttpService>().requestAndHandle<T>(
        request,
        parseModel: creator(),
      );
    } catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  Future<List<T>> callRemoteList<T extends IRestApiBaseModel>(
      IRestApiRequest request, T Function() creator) async {
    try {
      return locator<RestApiHttpService>().requestAndHandleList<T>(
        request,
        parseModel: creator(),
      );
    } catch (e) {
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  Future<T> callMock<T extends IRestApiBaseModel>(
      String mockUrl, T Function() parseModel) async {
    final data = await rootBundle.loadString(mockUrl);
    final json = jsonDecode(data);
    final campaigns = parseModel().fromJson(json);
    return campaigns;
  }

  Future<List<T>> callMockList<T extends IRestApiBaseModel>(
      String mockUrl, T Function() parseModel) async {
    final data = await rootBundle.loadString(mockUrl);
    final json = jsonDecode(data);
    final campaigns = (json as List)
        .map<T>((campaign) => parseModel().fromJson(campaign))
        .toList();
    return campaigns;
  }
}

typedef DataModel<T> = Either<Failure, T>;
typedef ModelReturnType<T> = Either<T, List<T>>;
typedef ReturnType<T> = Either<Failure, ModelReturnType<T>>;

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}
