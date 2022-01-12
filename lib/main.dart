import 'package:flutter/material.dart';
import 'package:networking_in_flutter/parsing_json/json_parsing.dart';
import 'package:networking_in_flutter/parsing_json/json_parsing_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JsonParsingMap()
    );
  }//
}
