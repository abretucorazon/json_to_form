import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
const _formCollectionName = "forms";

class AppModel {
  AppModel() {}

  AppModel call() => GetIt.I<AppModel>();

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    GetIt.I.registerSingleton<AppModel>(AppModel());
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
