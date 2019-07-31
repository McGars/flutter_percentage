import 'package:flutter/material.dart';

abstract class BaseScreen extends StatelessWidget {

  final String _title;

  BaseScreen({String title}): _title = title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: body(),
    );
  }

  Widget body();

}