import 'package:flutter/material.dart';
import 'package:jisho/jisho.dart';

void main() {
  print("${search_im(query: "人間")}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text("hey"), //${search(index: "./index", query: "人間")}
        ),
      ),
    );
  }
}
