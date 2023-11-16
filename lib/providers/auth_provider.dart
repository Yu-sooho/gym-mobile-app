import 'package:gym_calendar/utils/package_util.dart';

class SocialLoginProvider {
  Future<dynamic> postKakaoLogin(option) async {
    try {
      Networks networks = Networks();
      final res = networks.httpPost(
        uri:
            "http://127.0.0.1:5001/gymcalendar-20206/us-central1/kakaoAuth/kakaoLogin",
        body: option,
      );
      return res;
    } catch (error) {
      print('KakaoProvider: $error');
      rethrow;
    }
  }

  Future<dynamic> postNaverLogin(option) async {
    try {
      Networks networks = Networks();
      final res = networks.httpPost(
        uri:
            "http://127.0.0.1:5001/gymcalendar-20206/us-central1/naverAuth/naverLogin",
        body: option,
      );
      return res;
    } catch (error) {
      print('NaverProvider: $error');
      rethrow;
    }
  }
}
