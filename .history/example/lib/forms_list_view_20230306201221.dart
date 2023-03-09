import 'package:flutter/material.dart';
//import 'package:json_to_form/json_schema.dart';
//import 'create_form_field.dart';
//import 'questionnaire_preview.dart';
import 'app_model.dart';
import 'ui_utils.dart';
import 'form_field_schema.dart';

/*
// Screen to create a text question
Widget inputQuestionScreen() {
   return CreateFormField(FormFieldSchema.getInputMetaSchema());
}

// Screen to create a selection question
Widget selectionQuestionScreen() {
  return CreateFormField(FormFieldSchema.getSelectionMetaSchema());
}

// Screen to preview all the questions as a form
Widget previewQuestionaireScreen() {
  return QuestionnairePreview(testForm);
}
*/

class QuestionFormsListView extends StatefulWidget {
  QuestionFormsListView(this.formsList, {Key? key}) : super(key: key);

  final List<Json>? formsList;

  @override
  _QuestionFormsListView createState() => new _QuestionFormsListView();

// Class method to extract arguments from route to create an instance of this class
  static Widget navigateTo(BuildContext context) {
    final ModalRoute<Object?>? route = ModalRoute.of(context);
    final forms = route?.settings.arguments as List<Json>?;

    // Create and return a UI screen that displays the list of forms
    // Display an error message if the list of forms is not found in
    // the argument of navigation route
    return (forms != null)
        ? QuestionFormsListView(forms)
        : errorScreen(context, 'List of Forms is missing');
  }
}

class _QuestionFormsListView extends State<QuestionFormsListView> {
  dynamic response;

  // Save newly created form to the list of forms and refresh list view
  saveNewForm(Map<String, dynamic>? formMetaData) {
    print("SAVE NEW FORM");
    print(formMetaData);

    if (formMetaData != null) {
      Map<String, dynamic> formSchema = {};

      final fields = formMetaData['fields'] as List<Map<String, dynamic>>?;
      if (fields != null) {
        fields.forEach((Map<String, dynamic> fieldMetaData) {
          final String? key = fieldMetaData['name'] as String;
          final String? value = fieldMetaData['value'];
          if (key != null && value != null) {
            formSchema[key] = value;
          }
        });

        if (formSchema.isNotEmpty) {
          // Save new form
          formSchema['fields'] = <Map<String, dynamic>>[];
          widget.formsList.add(formSchema);

          // Refresh UI to show new question
          setState(() {
            response = formMetaData;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display List of forms screen
    return new Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Forms"),
          actions: <Widget>[
            /* IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),*/
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add new form',
              onPressed: () {
                Navigator.pushNamed(context, '/newForm',
                        arguments: FormFieldSchema.getFormMetaSchema())
                    .then((results) {
                  saveNewForm(results as Json);
                });
              },
            )
          ],
        ),
        body: ListView(
          children: widget.formsList
              .map<Widget>((field) => Card(
                      child: ListTile(
                    title: Text(field['title']),
                    subtitle: Text(field['description']),
                    onTap: () {
                      Navigator.pushNamed(context, '/questionsList',
                          arguments: field);
                    },
                  )))
              .toList(),
        ));
  }
}

// Test data for list of forms
final testForms = [kRegisterForm, kProfileForm];

// Profile form
final Map<String, dynamic> kProfileForm = {
  'title': 'Profile',
  'description': 'User profile',
  'fields': [
    {
      'key': getRandomKey(),
      'type': 'Input',
      'label': 'Full Name',
      'placeholder': "Enter Your first name and last name",
      'required': true,
    },
    {
      'key': getRandomKey(),
      'type': 'Date',
      'label': 'Date of birth',
      'placeholder': "Enter your Date of birth",
      'required': false,
    },
    {
      'key': getRandomKey(),
      'type': 'Input',
      'label': 'City of birth',
      'placeholder': "In which city were you born?",
      'required': false,
    },
  ],
};

// Register form
final Map<String, dynamic> kRegisterForm = {
  'title': 'Register',
  'description': 'Create your account',
  'fields': [
    {
      'key': getRandomKey(),
      'type': 'Input',
      'label': 'Name',
      'placeholder': "Enter Your Name",
      'required': true,
    },
    {
      'key': getRandomKey(),
      'type': 'Input',
      'label': 'Username',
      'placeholder': "Enter Your Username",
      'required': true,
      'decoration': InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        border: OutlineInputBorder(),
      ),
    },
    {
      'key': getRandomKey(),
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
      'key': getRandomKey(),
      'type': 'Password',
      'label': 'Password',
      'required': true,
      'decoration': InputDecoration(
          prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
    },
  ]
};
