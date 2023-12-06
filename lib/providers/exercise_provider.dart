import 'package:get/get.dart';
import 'package:gym_calendar/models/exercise_models.dart';
import 'package:gym_calendar/stores/package_stores.dart';

class ExerciseProvider {
  Stores stores = Stores();
  Future<bool> getMuscleList() async {
    try {
      final collectionName = stores.localizationController.language.value == 1
          ? 'muscles'
          : 'muscles';

      final res = await stores.firebaseFirestoreController
          .getCollectionData(collectionName);
      List<Muscles> list = [];
      for (var element in res.docs) {
        final id = element.get('id');
        final name = element.get('name');
        final imageURL = element.get('imageURL');
        final muscle = Muscles(id: id, name: name, imageURL: imageURL);
        list.add(muscle);
      }
      stores.exerciseStateController.muscles = list.obs;
      return true;
    } catch (error) {
      print('ExerciseProvider getMuscleList error: $error');
      rethrow;
    }
  }

  Future postCustomExercise(Map<String, dynamic> data) async {
    try {
      data['uid'] = stores.firebaseAuthController.uid?.value;
      await stores.firebaseFirestoreController.postCollectionDataSet(
          collectionName: 'user_exercise',
          docName: '${data['name']}${data['muclesId']}',
          obj: data);
      return true;
    } catch (error) {
      print('ExerciseProvider postCustomExercise error: $error');
      rethrow;
    }
  }
}
