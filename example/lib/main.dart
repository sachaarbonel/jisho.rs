import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jisho/jisho.dart';

import 'dart:async' show Completer, Future;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';

Future<String> loadFile(String filename,
    {String directory, String package}) async {
  var bytes = await rootBundle.load("packages/$package/$directory/$filename");
  String currentPath = (await getApplicationDocumentsDirectory()).path;
  await _writeToFile(bytes,
      path: currentPath,
      filename: filename,
      directory: directory,
      package: package);
  return currentPath;
}

Future<void> _writeToFile(ByteData data,
    {String path, String filename, String directory, String package}) {
  var completer = Completer();
  final buffer = data.buffer;
  Directory('$path/$package/$directory').create(recursive: true).then(
      (Directory dir) => completer.complete(File("${dir.path}/$filename")
          .writeAsBytes(
              buffer.asUint8List(data.offsetInBytes, data.lengthInBytes))));
  return completer.future;
}

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
            // future: dirContents(),
            future: loadFile("poem.txt", package: "jisho", directory: "assets"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              var result = snapshot.data;

              return snapshot.hasData
                  ? Text("${read_file("$result/jisho/assets/poem.txt")}")
                  : CircularProgressIndicator();
            },
          ), //${search(index: "./index", query: "人間")}
        ),
      ),
    );
  }
}
