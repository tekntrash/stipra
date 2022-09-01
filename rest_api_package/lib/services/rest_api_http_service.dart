part of '../rest_api_package.dart';

class RestApiHttpService {
  Map<String, String> publicHeaders = <String, String>{};
  Dio dio;
  DefaultCookieJar cookieJar;

  ///! Make sure base url ends with /
  ///So you can call your API like in the examples.
  final String baseUrl;

  ///! Make sure base url ends with /
  ///So you can call your API like in the examples.
  RestApiHttpService(
    this.dio,
    this.cookieJar,
    this.baseUrl,
  ) {
    log('Cookie interceptor adding');
    dio.interceptors.add(CookieManager(cookieJar));
    log('Cookie interceptor added');
  }

  Future<Options> prepareOptions({String? bearerToken}) async {
    final Map<String, String> headers = <String, String>{};
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    //headers.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json');

    if (bearerToken != null) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $bearerToken');
    }
    return Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 501) <= 500;
        });
  }

  Future<T> requestAndHandle<T>(
    IRestApiRequest apiRequest, {
    bool removeBaseUrl = false,
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    Response response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponse<T>(response,
        parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<List<T>> requestAndHandleList<T>(
    IRestApiRequest apiRequest, {
    bool removeBaseUrl = false,
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    Response response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponseList<T>(
      response,
      parseModel: parseModel,
      isRawJson: isRawJson,
    );
  }

  Future<Response> request(IRestApiRequest apiRequest,
      {bool removeBaseUrl = false}) async {
    Response resp;
    String url = baseUrl + apiRequest.endPoint;

    Options options = await prepareOptions(bearerToken: apiRequest.bearerToken);

    try {
      if (apiRequest.requestMethod == RequestMethod.GET) {
        resp = await dio.get(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await dio.put(
          url,
          options: options,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await dio.post(
          url,
          options: options,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.DELETE) {
        resp = await dio.delete(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
          data: apiRequest.body,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  Future<T> requestFormAndHandle<T>(
    IRestApiRequest apiRequest, {
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    Response response = await requestForm(apiRequest);
    return handleResponse<T>(response,
        parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<List<T>> requestFormAndHandleList<T>(
    IRestApiRequest apiRequest, {
    required dynamic parseModel,
    bool isRawJson = false,
  }) async {
    Response response = await requestForm(apiRequest);
    return handleResponseList<T>(response,
        parseModel: parseModel, isRawJson: isRawJson);
  }

  Future<Response> requestForm(
    IRestApiRequest apiRequest,
  ) async {
    Response resp;
    String url = apiRequest.endPoint;

    Options options = await prepareOptions(bearerToken: apiRequest.bearerToken);

    var formData = FormData();

    apiRequest.body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    try {
      if (apiRequest.requestMethod == RequestMethod.GET) {
        resp = await dio.get(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await dio.put(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await dio.post(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  Future<Response> requestFile(
    IRestApiRequest apiRequest, {
    required String fileFieldName,
    required File file,
    Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    Response? resp;
    String url = apiRequest.endPoint;

    Options options = await prepareOptions(bearerToken: apiRequest.bearerToken);

    var mfile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
    /*var mfile = MultipartFile.fromBytes(
      file.readAsBytesSync(),
      filename: file.path.split('/').last,
    );*/
    var formData = FormData();

    formData.files.add(MapEntry(fileFieldName, mfile));

    apiRequest.body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    try {
      if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await Dio().put(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
          cancelToken: cancelToken,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await Dio().post(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception(
          'URL: $url options: $options QueryParams: ${apiRequest.queryParameters} body: ${apiRequest.body} Response: ${resp?.toString()} fileName: $fileFieldName ---> DIO Error: $e Error response: ${e.response} Error message: ${e.message} stacktrace ${e.stackTrace} reqoptions: ${e.requestOptions}');
    }
    return resp;
  }

  T handleResponse<T>(Response response,
      {required dynamic parseModel, required bool isRawJson}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        if (isRawJson) {
          return parseModel.fromRawJson(data);
        }
        return parseModel.fromJson(data);
      } catch (e) {
        throw response;
      }
    } else {
      throw response;
    }
  }

  List<T> handleResponseList<T>(Response response,
      {required dynamic parseModel, required bool isRawJson}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        log('Response data: $data');
        if (isRawJson) {
          final list = json.decode(data) as List;
          return List<T>.from(list.map((x) => parseModel.fromJson(x)));
        }
        return List<T>.from(data.map((x) => parseModel.fromJson(x)));
      } catch (e) {
        return parseModel.fromJson({});
      }
    } else {
      return [parseModel.fromJson({})];
    }
  }
}
