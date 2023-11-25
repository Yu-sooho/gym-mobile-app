import 'package:gym_calendar/utils/package_util.dart';

class SocialLoginProvider {
  Future<dynamic> postKakaoLogin(option) async {
    try {
      Networks networks = Networks();
      final res = networks.httpPost(
        uri: "${networks.baseUrl}kakaoAuth/kakaoLogin",
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
        uri: "${networks.baseUrl}naverAuth/naverLogin",
        body: option,
      );
      return res;
    } catch (error) {
      print('NaverProvider: $error');
      rethrow;
    }
  }
}
