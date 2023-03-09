import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


class AppState {
 
 AppState() {
  await init();
 }

 init() async { 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 }

}