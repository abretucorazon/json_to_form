import 'package:flutter/material.dart';
import 'package:json_to_form/json_schema.dart';
import 'ui_utils.dart';

class FormPreview extends StatefulWidget {
  final Map<String, dynamic> form;

  FormPreview(this.form, {Key? key}) : super(key: key);

  @override
  _FormPreview createState() => new _FormPreview();

  // Class method to extract arguments from route to create an instance of this class
  static Widget navigateTo(BuildContext context) {
    final route = ModalRoute.of(context);
    final form = (route != null)
        ? (route.settings.arguments as Map<String, dynamic>)
        : null;

    // Create and return a UI screen that displays the list of forms
    // Display an error message if the list of forms is not found in
    // the argument of navigation route
    return (form != null)
        ? FormPreview(form)
        : errorScreen(
            context, 'Preview failed - Schema for Questions is missing');
  }
}

class _FormPreview extends State<FormPreview> {
  dynamic response;

/*
  Map decorations = {
    'input1': InputDecoration(
      prefixIcon: Icon(Icons.account_box),
      border: OutlineInputBorder(),
    ),
    'password1': InputDecoration(
        prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
  };
*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Preview: " +
            ((widget.form['title'] != null) ? widget.form['title'] : '')),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new JsonSchema(
            //decorations: decorations,
            form: '',
            formMap: widget.form,
            onChanged: (dynamic response) {
              this.response = response;
            },
            actionSave: (data) {
              print(data);
              Navigator.pop(context);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            buttonSave: new Container(
              height: 40.0,
              color: Colors.blueAccent,
              child: Center(
                child: Text("Done",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
