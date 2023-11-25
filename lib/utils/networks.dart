import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Networks {
  final bool isDev = false;

  late String baseUrl = isDev
      ? 'http://127.0.0.1:5001/gymcalendar-20206/us-central1/'
      : 'https://us-central1-gymcalendar-20206.cloudfunctions.net/';
  Future<dynamic> httpPost(
      {String uri = '', Object? body, HttpHeaders? header}) async {
    Uri parseUri = Uri.parse(uri);
    try {
      if (uri.isEmpty) return false;
      final response = await http.post(parseUri, body: body);
      final parsedJson = jsonDecode(response.body);
      print(
          'Networks httpPost uri:$uri body:$body header:$header statusCode:${response.statusCode} response:$parsedJson');
      if (response.statusCode != 200 && response.statusCode != 202) {
        throw parsedJson['message'];
      }
      return parsedJson;
    } catch (error) {
      final errorMessage = error.toString();
      if (errorMessage.contains("Connection refused")) {
        throw 'network Error';
      }
      print('httpPost error: $error');
      rethrow;
    }
  }
}
