import 'package:flutter/material.dart';
//import 'package:json_to_form/json_schema.dart';
import 'app_model.dart';
import 'form_field_schema.dart';
import 'ui_utils.dart';

class QuestionsListView extends StatefulWidget {
  final Map<String, dynamic> formSchema;

  QuestionsListView(this.formSchema, {Key? key}) : super(key: key);

  @override
  _QuestionsListView createState() => new _QuestionsListView();

  // Class method to extract arguments from route to create an instance of this class
  static Widget navigateTo(BuildContext context) {
    final route = ModalRoute.of(context);
    final args = (route != null)
        ? (route.settings.arguments as Map<String, dynamic>)
        : null;
    final form = (args != null) ? args : testForm;

    // Create and return a UI screen that displays the list of forms
    // Display an error message if the list of forms is not found in
    // the argument of navigation route
    return (form != null)
        ? QuestionsListView(form)
        : errorScreen(context,
            'Cannot display questions - Schema for Questions is missing');
  }
}

class _QuestionsListView extends State<QuestionsListView> {
  dynamic response;
  Json? formSchema;

  // Save newly created question to the list of questions and refresh list view
  saveAction(Map<String, dynamic> fieldMetaData) {
    print("SAVE ACTION");
    print(fieldMetaData);

    if (fieldMetaData != null) {
      Map<String, dynamic> fieldSchema = textMetaToSchema(fieldMetaData);
      if (formSchema['fields'] != null) {
        formSchema['fields'].add(fieldSchema);

        // Refresh UI to show new question
        setState(() {
          response = fieldMetaData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final route = ModalRoute.of(context);
    final routeArg = (route != null)
        ? (route.settings.arguments as Map<String, dynamic>)
        : null;
    formSchema = (routeArg != null) ? routeArg : testForm;

    // Display an error message if the list of questions is not found in
    // the argument of navigation route
    if (formSchema == null) {
      return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text("Error"),
        ),
        body: Center(
          child: Text('List of Questions is missing'),
        ),
      );
    }

    // Return screen to display list of questions
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text((formSchema['title'] as String) + " Questions"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.input),
                title: Text('Add Question'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/textQuestion',
                          arguments: FormFieldSchema.getInputMetaSchema())
                      .then((results) {
                    saveAction(results);
                  });
                },
              ),

/*            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Selection'),
              onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/selectionQuestion', arguments:FormFieldSchema.getSelectionMetaSchema());
              },
            ),
*/

              ListTile(
                leading: Icon(Icons.preview),
                title: Text('Preview Form'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/previewQuestionaire',
                      arguments: formSchema);
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Go Back'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.maybePop(context);
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: (formSchema['fields'] as List<Map<String, dynamic>>)
              .map<Widget>((Map<String, dynamic> field) => Card(
                      child: ListTile(
                    title: Text(field['label']),
                    subtitle: Text((field['value'] != null)
                        ? '${field['value']}'
                        : '(empty)'),
                  )))
              .toList(),
        ));
  }
}

// Test data for questions
final Map<String, dynamic> testForm = {
  'fields': [
    {
      'key': 'name',
      'type': 'Input',
      'label': 'Name',
      'placeholder': "Enter Your Name",
      'required': true,
    },
    {
      'key': 'username',
      'type': 'Input',
      'label': 'Username',
      'placeholder': "Enter Your Username",
      'required': true,
      'decoration': InputDecoration(
        prefixIcon: Icon(Icons.input),
        border: OutlineInputBorder(),
      ),
    },
    {
      'key': 'email',
      'type': 'Email',
      'label': 'email',
      'required': true,
      'decoration': InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    },
    {
      'key': 'password1',
      'type': 'Password',
      'label': 'Password',
      'required': true,
      'decoration': InputDecoration(
          prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
    },
    {
      'key': 'number',
      'type': 'Input',
      'label': 'number',
      'required': true,
      'decoration': InputDecoration(
          prefixIcon: Icon(Icons.format_list_numbered),
          border: OutlineInputBorder()),
      'keyboardType': TextInputType.number
    },
    {
      'key': 'date',
      'type': 'Date',
      'label': 'date',
      'required': true,
      'decoration': InputDecoration(
          prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
    },
  ]
};
