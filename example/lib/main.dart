import 'package:flutter/material.dart';
import 'package:jisho/jisho.dart';

void main() {
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
          child: FutureBuilder<String>(
            future: loadIndex(context),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              var result = snapshot.data;

              return snapshot.hasData
                  ? Text(
                      "${search(index: "$result/jisho/index/", query: "人間")}")
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
