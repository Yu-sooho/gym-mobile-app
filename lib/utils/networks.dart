import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Networks {
  Future<dynamic> httpPost(
      {String uri = '', Object? body, HttpHeaders? header}) async {
    Uri parseUri = Uri.parse(uri);
    try {
      if (uri.isEmpty) return false;
      final response = await http.post(parseUri, body: body);
      final parsedJson = jsonDecode(response.body);
      print(
          'Networks httpPost uri:$uri body:$body header:$header response:$parsedJson');
      if (parsedJson['code'] != 200 || parsedJson['code'] != 202) {
        throw parsedJson['message'];
      }
      return parsedJson;
    } catch (error) {
      final errorMessage = error.toString();
      if (errorMessage.contains("Connection refused")) {
        throw 'network Error';
      }
      print('httpPost: $error');
      rethrow;
    }
  }
}
