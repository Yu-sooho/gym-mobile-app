import 'package:get/get.dart';
import 'auth_provider.dart';
import 'exercise_provider.dart';

class NetworkProviders extends GetxController {
  SocialLoginProvider socialLoginProvider = SocialLoginProvider();
  ExerciseProvider exerciseProvider = ExerciseProvider();
}
