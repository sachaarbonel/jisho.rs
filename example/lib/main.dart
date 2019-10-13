import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jisho/jisho.dart';

import 'dart:async' show Completer, Future;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';

Future<List<FileSystemEntity>> dirContents(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = Completer();
  var lister = dir.list(recursive: false);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}

Future<String> loadPath() async {
  var filename = "poem.txt";
  var bytes = await rootBundle.load("packages/jisho/assets/$filename");
  String dir = (await getApplicationDocumentsDirectory()).path;
  await writeToFile(bytes, '$dir/$filename');
  return dir;
}

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

void main() {
  // print(
  //     "${read_file("/data/user/0/com.example.jisho_example/app_flutter/poem.txt")}");
  //print("${search_im(query: "人間")}");
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
          //    child: Text(
          // "${read_file("/data/user/0/com.example.jisho_example/app_flutter/poem.txt")}"),
          child: FutureBuilder<String>(
            future: loadPath(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //print(snapshot.data);
              return snapshot.hasData
                  ? Text(
                      "${read_file("/data/user/0/com.example.jisho_example/app_flutter/poem.txt")}")
                  //  ? Text(snapshot.data)
                  : CircularProgressIndicator();
            },
          ), //${search(index: "./index", query: "人間")}
        ),
      ),
    );
  }
}
