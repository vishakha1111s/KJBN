import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
export '../utils/logger.dart';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'logger.dart';


const int connectTimeout = 20000;
const int sendTimeout = 40000;
const int receiveTimeout = 20000;

class CoreApplication {
  factory CoreApplication() {
    return _instance;
  }

  static const TAG = "Core Application";

  static final CoreApplication _instance = CoreApplication._internal();
  late Dio dio;

  Future<Map<String, dynamic>> get(
      String uri, Map<String, dynamic>? queryParams) async {
    var url = Uri.https('https://api.tfl.gov.uk',
        '/Vehicle/200/Arrivals', queryParams);

    var response = await http.get(url, headers: {
      'apiKey': "60a7723f26f84f5e82532e07f47b119d"
    });
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  CoreApplication._internal() {
    dio = Dio(BaseOptions(
        connectTimeout: connectTimeout,
        //ms
        sendTimeout: sendTimeout,
        receiveTimeout: 20000,
        //ms
        baseUrl: "https://api.tfl.gov.uk"));

    dio.interceptors.add(AppInterceptors());

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
  }

  static const int _maxCharactersPerLine = 200;

  //Print the string wrapped
  void printWrapped(String value) {
    if (value.length > _maxCharactersPerLine) {
      int iterations = (value.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > value.length) {
          endingIndex = value.length;
        }
        AppLogger.log(value.substring(i * _maxCharactersPerLine, endingIndex),
            tag: "API logger");
      }
    } else {
      AppLogger.log(value, tag: "API logger");
    }
  }

  resetDioTimeouts() {
    dio.options.sendTimeout = sendTimeout;
    dio.options.connectTimeout = connectTimeout;
  }
}
class AppInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    AppLogger.log("<===========================================>",
        tag: "API logger");
    AppLogger.log("<==============Request Started==============>",
        tag: "API logger");
    AppLogger.log("<===========================================>",
        tag: "API logger");
    if (!options.headers.containsKey("apiKey")) {
      options.headers["apiKey"] =
      "60a7723f26f84f5e82532e07f47b119d";
    }
    printWrapped(toCurlCmd(options), "API logger");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    AppLogger.log("<===========================================>",
        tag: "API logger");
    AppLogger.log("<==============Request Success==============>",
        tag: "API logger");
    AppLogger.log("<===========================================>",
        tag: "API logger");
    printWrapped(response.data.toString(), "API logger");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    AppLogger.log("<===========================================>",
        tag: "API logger");
    AppLogger.log("<==============Request Error================>",
        tag: "API logger");
    AppLogger.log("<===========================================>",
        tag: "API logger");
    printWrapped(err.toString(), "API logger");
  }

  void printWrapped(String text, String tag) {
    final pattern = RegExp('.{1,800}');
    if (pattern.hasMatch(text)) {
      // 800 is the size of each chunk
      pattern
          .allMatches(text)
          .forEach((match) => AppLogger.log(match.group(0) ?? "", tag: tag));
    } else {
      AppLogger.log(text, tag: tag);
    }
  }
}




String toCurlCmd(RequestOptions req) {
  String cmd = "curl";

  String header = req.headers
      .map((key, value) {
    if (key == "content-type" &&
        value.toString().contains("multipart/form-data")) {
      value = "multipart/form-data;";
    }
    return MapEntry(key, "-H '$key: $value'");
  })
      .values
      .join(" ");
  String url = "${req.baseUrl}${req.path}";
  if (req.queryParameters.isNotEmpty) {
    String query = req.queryParameters
        .map((key, value) {
      return MapEntry(key, "$key=$value");
    })
        .values
        .join("&");

    url += (url.contains("?")) ? query : "?$query";
  }
  if (req.method == "GET") {
    cmd += " $header '$url'";
  } else {
    Map<String, dynamic> files = {};
    String postData = "-d ''";
    if (req.data != null) {
      if (req.data is FormData) {
        FormData fdata = req.data as FormData;
        for (var element in fdata.files) {
          MultipartFile file = element.value;
          files[element.key] = "@${file.filename}";
        }
        for (var element in fdata.fields) {
          files[element.key] = element.value;
        }
        if (files.isNotEmpty) {
          postData = files
              .map((key, value) => MapEntry(key, "-F '$key=$value'"))
              .values
              .join(" ");
        }
      } else if (req.data is Map<String, dynamic>) {
        files.addAll(req.data);

        if (files.isNotEmpty) {
          postData = "-d '${jsonEncode(files).toString()}'";
        }
      }
    }

    String method = req.method.toString();
    cmd += " -X $method $postData $header '$url'";
  }

  return cmd;
}