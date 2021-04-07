
// Create a Form widget.
import 'package:flutter/material.dart';

typedef Callback<T> = void Function(T value);
typedef OnValueChange<T> = Callback<T> Function(String key);
typedef Builder = Widget Function(BuildContext context,Callback<Callback<Map<String,dynamic>>> validate);
typedef FieldsBuilder = Widget Function(BuildContext context,OnValueChange validate);
class CustomForm extends StatefulWidget {
  final Builder buttonBuilder;
  final FieldsBuilder fieldsBuilder;
  CustomForm(this.buttonBuilder,this.fieldsBuilder);

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CustomFormState extends State<CustomForm> {
  
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  Map<String,dynamic> values=Map();

  void validate(Callback<Map<String,dynamic>> onSubmit){
      if (_formKey.currentState.validate()) {
        onSubmit(values);
      }
  }
  Callback<dynamic> onValueChange(String key){
    return (dynamic value){
      values.update(key, value);
    };
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.fieldsBuilder(context, onValueChange)
          // TextFormField(
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),
          ,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: widget.buttonBuilder(context, validate)
            // ElevatedButton(
            //   onPressed: () {
            //     // Validate returns true if the form is valid, or false
            //     // otherwise.
            //     if (_formKey.currentState.validate()) {
            //       // If the form is valid, display a Snackbar.
            //       Scaffold.of(context)
            //           .showSnackBar(SnackBar(content: Text('Processing Data')));
            //     }
            //   },
            //   child: Text('Submit'),
            // ),
          ),
        ],
      ),
    );
  }
}