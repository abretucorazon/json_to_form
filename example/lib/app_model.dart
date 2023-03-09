import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

typedef Json = Map<String, dynamic>;

FirebaseFirestore _firestore = FirebaseFirestore.instance;
const _formCollectionName = "forms";

class AppModel {
  AppModel() {}

  static bool _initialized = false;

  static AppModel get() {
    if (!_initialized) {
      throw "Call AppModel.init() before first use";
    }
    return GetIt.I<AppModel>();
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

  Future<Json> loadForm(String formId) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection(_formCollectionName).doc(formId).get();

    final Json formMap =
        (documentSnapshot.exists) ? documentSnapshot.data() as Json : {};

    print(
        'Finish loading document: ${formId} in collection: ${_formCollectionName}');

    return formMap;
  }
}
