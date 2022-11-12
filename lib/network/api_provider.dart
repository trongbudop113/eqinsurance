import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eqinsurance/network/custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "https://internet.eqinsurance.com.sg/test/testwebMobile/eqws.asmx/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var link = _baseUrl + url;
      print("call API $link");
      final response = await http.get(Uri.tryParse(link)!);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fetchData(String uri, dynamic data) async{
    http.Response response;
    var responseJson;
    var body = data.toMap();
    var link = _baseUrl+uri;
    try {
      response = await http.post(
        Uri.parse(link),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );

      print("API response: $link $body ${response.body}");
      if(response.statusCode == 200){
        responseJson = response.body;
      }else{
        responseJson = null;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fetchDataUpdateDevice(String uri, dynamic data) async{
    http.Response response;
    var responseJson;
    var body = data.toMap();

    try {
      response = await http.post(
        Uri.parse(uri),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: body,
      );

      print("API response: $uri $body ${response.body}");
      if(response.statusCode == 200){
        responseJson = response.body;
      }else{
        responseJson = null;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> pushNotification(String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  int _messageCount = 0;
  String constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}