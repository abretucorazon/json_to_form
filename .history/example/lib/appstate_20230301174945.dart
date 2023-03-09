import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
const _formCollectionName = "forms";

class AppState {
  AppState() {}

  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Map<String, dynamic> loadForm(String formId) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection(_formCollectionName).doc(formId).get();

    var formMap = {};
    if (documentSnapshot.exists) {
      formMap = documentSnapshot.data();
      print('Document data: ${formMap}');
    } else {
      print('Document does not exist on the database');
    }

    return formMap;
  }
}
