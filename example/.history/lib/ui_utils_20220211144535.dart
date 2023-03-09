import 'package:flutter/material.dart';

// Return a screen displaying an error message
Widget errorScreen(BuildContext context, String errorMsg) {
  return 
    new Scaffold(
      appBar: new AppBar(
        title: new Text("Error!"),
      ),
       body: Center(
        child: Text(errorMsg),
        ),
      );
}