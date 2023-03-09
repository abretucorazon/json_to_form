import 'dart:math' show Random;

// Generate random keys for a field in Json Schema
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//const _prefixString = 'key_';
//const _randomSuffixLen = 4;
Random _rnd = Random.secure();

String getRandomKey({String prefixString = 'key_', int KeyLength = 10}) =>
    prefixString +
    String.fromCharCodes(Iterable.generate(KeyLength - prefixString.length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// Extract data from meta Schema for a text question - return the json schema for that question
Map<String, dynamic> textMetaToSchema(Map<String, dynamic> meta) {
  Map<String, dynamic> schema = {};

  if (meta['fields'] != null) {
    meta['fields'].forEach((field) {
      String key = field['name'];
      dynamic value = (field['value'] == null) ? '' : field['value'];

      // Handle checkbox items in meta for attributes like 'required'
      if (key == 'attributes') {
        if (field['items'] != null) {
          field['items'].forEach((attr) {
            String attKey = attr['name'];
            dynamic attValue = (attr['value'] == null) ? '' : attr['value'];
            if (attKey != null) {
              schema[attKey] = attValue;
              print('Attribute = ' + attKey + ': ' + attValue.toString());
            }
          });
        }
      } else if (key != null) {
        schema[key] = value;
        print('Field = ' + key + ': ' + value.toString());
      }
    });
  }

  // Add a unique key to this field required for form validation
  schema['key'] = (schema['label'] as String) + '__' + getRandomKey();
  print(schema);

  return schema;
}

class FormFieldSchema {
//  static final textFieldSchema = kTextFieldSchema;
//  static final selectionFieldSchema = kSelectionFieldSchema;

  // Return a fresh new meta Schema for selection input field
  static Map<String, dynamic> getSelectionMetaSchema() {
    return {
      'title': 'Create a selection input field',
      'description':
          'Create the Json Schema for a selection input field of a form',
      //'autoValidated': true,
      'fields': [
        /*{ 
              // key field
              'key': getRandomKey(),
              'type': 'Input',
              'label': 'Key',
              'placeholder': "A unique key for this field",
              'value': getRandomKey(),
              'required': true
            },
            */
        {
          // type field
          'key': getRandomKey(),
          'type': 'Select',
          'label': 'Field Type',
          'placeholder': "Select",
          'value': 'Select',
          'items': [
            {
              'label': "Select",
              'value': "Select",
            },
            {
              'label': "Checkbox",
              'value': "Checkbox",
            },
            {
              'label': "RadioButton",
              'value': "RadioButton",
            }
          ],
          'required': true,
        },
        {
          // label field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Field Label',
          'placeholder': "What do users select from this field eg. Meal Time",
          'value': '',
          'required': true,
        },
        {
          // separator string for list of selection items
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Separator string',
          'placeholder':
              "Enter a string to separate item names in the list of item name in the field below",
          'value': '|',
          'required': true
        },
        {
          // List of selection item names
          'key': getRandomKey(),
          'type': 'Input', //'TareaText',
          'label': 'List of Selection Item Names',
          'placeholder':
              'Enter Item Names separated by the separator string from the field above eg. Breakfast | Lunch | Dinner',
        },
        {
          // List of selection item values
          'key': getRandomKey(),
          'type': 'Input', //'TareaText',
          'label': 'List of Selection Item Values',
          'placeholder':
              'Enter the value for each Item Name from the field above, separated by the separator string eg. 7am | 12pm | 5pm',
        },
        {
          // value field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Default Selection Value',
          'placeholder':
              "Enter an item value from the 'List of Selection Item Values' above",
          'required': true,
        },
        {
          // Attribute fields: 'required', 'readOnly'
          'key': getRandomKey(),
          'type': 'Checkbox',
          'label': 'Attributes',
          'name': 'attributes',
          'items': [
            {
              'label': 'Required',
              'value': true,
              'name': 'required',
            },
            {
              'label': 'Read-only',
              'value': false,
              'name': 'readOnly',
            },
          ],
        },
      ]
    };
  }

  // Return a fresh new meta Schema for text input field
  static Map<String, dynamic> getInputMetaSchema() {
    return {
      'title': 'Create a text input question',
      'description':
          'Create the Json Schema for a text input question to be used in a form',
      //'autoValidated': true,
      'fields': [
        /*
              { // key field
                'key': getRandomKey(),
                'type': 'Input',
                'label': 'Key',
                'placeholder': "A unique key for this field",
                'value': getRandomKey(),
                'required': true,
                'name' : 'key',
              },
              */
        {
          // label field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Field Label',
          'placeholder': "What do users enter in this field",
          'value': '',
          'required': true,
          'name': 'label',
        },
        {
          // placeholder field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Field Placeholder',
          'placeholder': "Placeholder value for this field",
          'value': '',
          'required': false,
          'name': 'placeholder',
        },
        {
          // type field
          'key': getRandomKey(),
          'type': 'Select',
          'label': 'Input Type',
          'value': 'Input',
          'items': [
            {
              'label': "Text",
              'value': "Input",
            },
            {
              'label': "Email",
              'value': "Email",
            },
            {
              'label': "Password",
              'value': "Password",
            },
            {
              'label': "Date",
              'value': "Date",
            }
          ],
          'required': true,
          'name': 'type',
        },
        {
          // value field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Field Default Value',
          'placeholder': "Enter a default value for this field",
          'value': '',
          'required': false,
          'name': 'value',
        },
        {
          // Attribute fields
          'key': getRandomKey(),
          'type': 'Checkbox',
          'label': 'Attributes',
          'name': 'attributes',
          'items': [
            {
              'label': 'Required',
              'value': true,
              'name': 'required',
            },
            {
              'label': 'Read-only',
              'value': false,
              'name': 'readOnly',
            },
          ],
        },
      ]
    };
  }

  // Return a fresh new meta Schema for text input field
  static Map<String, dynamic> getFormMetaSchema() {
    return {
      'title': 'Create a new form',
      'description': 'Gather Data for a new form',
      //'autoValidated': true,
      'fields': [
        {
          // title field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Title',
          'placeholder': "Enter a title for the new form",
          'value': '',
          'required': true,
          'name': 'title',
        },
        {
          // description field
          'key': getRandomKey(),
          'type': 'Input',
          'label': 'Description',
          'placeholder': "Enter a description about this form",
          'value': '',
          'required': true,
          'name': 'description',
        },
      ],
    };
  }
}
