//import 'dart:convert';

import 'package:flutter/material.dart';
import 'all_fields.dart';
//import 'login.dart';
//import 'register.dart';
//import 'register_with_map.dart';
//import 'all_fields_v1.dart';
import 'forms_list_view.dart';
import 'questions_list_view.dart';
import 'question_create_screen.dart';
import 'form_preview.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Forms',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.red,
      ),
      initialRoute: "/allfields",
      routes: {
        '/': (context) => QuestionFormsListView.navigateTo(context),
        '/questionsList': (context) => QuestionsListView.navigateTo(context),
        '/newForm': (context) => CreateQuestionScreen.navigateTo(context),
        '/textQuestion': (context) => CreateQuestionScreen.navigateTo(context),
        '/selectionQuestion': (context) =>
            CreateQuestionScreen.navigateTo(context),
        '/previewQuestionaire': (context) =>
            QuestionnairePreview.navigateTo(context),
//        '/allfieldsv1': (context) => AllFieldsV1(),
        '/allfields': (context) => AllFields(),
//        '/login': (context) => Login(),
//        '/register': (context) => Register(),
//        '/registerMap': (context) => RegisterMap(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic response;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Test Form Json Schema"),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(children: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/formsList');
            },
            child: Text("Forms List"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/textQuestion');
            },
            child: Text("Text Question"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/selectionQuestion');
            },
            child: Text("Selection Question"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/allfieldsv1');
            },
            child: Text("All Fields V1"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/allfields');
            },
            child: Text("All Fields"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text("Login Form Test"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text("Register Form Test"),
          ),
          new ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registerMap');
            },
            child: Text("Register Form Test with Map"),
          ),
        ]),
      ),
    );
  }
}
