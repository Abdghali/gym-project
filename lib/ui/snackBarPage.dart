import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  String title;
  SnackBarPage({this.title});
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text('$title'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}
