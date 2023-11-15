import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialLoginProvider {
  Future<dynamic> postKakaoLogin(option) async {
    print(option);
    Uri uri = Uri.parse(
        "http://127.0.0.1:5001/gymcalendar-20206/us-central1/kakaoAuth/kakaoLogin");
    try {
      final response = await http.post(uri, body: option);
      final parsedJson = jsonDecode(response.body);
      return parsedJson;
    } catch (error) {
      print('KakaoProvider: $error');
      return false;
    }
  }
}
