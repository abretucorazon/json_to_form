import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

typedef Json = Map<String, dynamic>;

FirebaseFirestore _firestore = FirebaseFirestore.instance;
const _formCollectionName = "forms";
const _createdFieldName = "created";
const _lastEditedFieldName = "last_edited";

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
    final documentSnapshot = await _firestore
        .collection(_formCollectionName)
        .doc(formId)
        .withConverter<Json>(fromFirestore: (snapshot, _) {
      // Convert document fields ["created", "last_edited"] from type TimeStamp to DateTime string
      final form = snapshot.data();
      form?[_createdFieldName] =
          (form[_createdFieldName] as Timestamp?)?.toDate().toString();
      form?[_lastEditedFieldName] =
          (form[_lastEditedFieldName] as Timestamp?)?.toDate().toString();
      return form ?? {};
    }, toFirestore: (form, _) {
      // Convert Json fields ["created", "last_edited"] from type DateTime strings to TimeStamp
      form[_createdFieldName] = (form[_createdFieldName] == null)
          ? Timestamp.now()
          : Timestamp.fromDate(DateTime.parse(form[_createdFieldName]));
      form[_lastEditedFieldName] = Timestamp.now();

      print("TimeStamp Converted to DateTime string: ${form} ");

      return form;
    }).get();

    final Json formMap =
        (documentSnapshot.exists) ? documentSnapshot.data() as Json : {};

    print(
        'Finish loading document: ${formId} in collection: ${_formCollectionName}');
    print(formMap);
    return formMap;
  }
}
