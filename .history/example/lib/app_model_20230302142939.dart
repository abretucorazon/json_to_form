import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
const _formCollectionName = "forms";

class AppModel {
  AppModel() {}

  static bool _initialized = false;

  AppModel call() {
    if (_initialized) {
      GetIt.I<AppModel>();
    } else {
      throw "Call AppModel.init() before first use";
    }
  }

  static Future<void> init() async {
    if (!_initialized) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      GetIt.I.registerSingleton<AppModel>(AppModel());

      _initialized = true;
    }
  }

  Future<Map> loadForm(String formId) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection(_formCollectionName).doc(formId).get();

    var formMap = {};
    if (documentSnapshot.exists) {
      formMap = documentSnapshot.data();
      print('Document data: ${formMap}');
    } else {
      print(
          'Document: ${formId} does not exist in collection: ${_formCollectionName}');
    }

    return formMap;
  }
}
