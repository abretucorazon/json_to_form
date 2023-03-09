//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_to_form/json_schema.dart';
import 'ui_utils.dart';

class CreateQuestionScreen extends StatefulWidget {

  final Map<String,dynamic> form;

  CreateQuestionScreen(Map<String,dynamic> this.form, {Key key}) : super(key: key);

  @override
  _CreateQuestionScreen createState() => new _CreateQuestionScreen();


  // Class method to extract arguments from route to create an instance of this class 
  static Widget navigateTo(BuildContext context) {
    final route = ModalRoute.of(context);
    final form = (route != null) ? (route.settings.arguments as Map<String,dynamic>) : null;

    // Create and return a UI screen that displays the list of forms
    // Display an error message if the list of forms is not found in 
    // the argument of navigation route
    return 
      (form != null) 
      ? CreateQuestionScreen(form) 
      : errorScreen(context,'Cannot create question - Form schema is missing');
  }

}

class _CreateQuestionScreen extends State<CreateQuestionScreen> {
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
        title: new Text(widget.form['title']),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(children: <Widget>[
            new JsonSchema(
              form: null,
              formMap: widget.form,
              onChanged: (dynamic response) {
                this.response = response;
                //print(jsonEncode(response));
              },
              actionSave: (data) {
//                print(jsonEncode(data));
                Navigator.pop(context,data);
              },
              autovalidateMode: AutovalidateMode.always,
              buttonSave: new Container(
                height: 40.0,
                color: Colors.blueAccent,
                child: Center(
                  child: Text("Save",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
