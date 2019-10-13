import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jisho/jisho.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';

Future<ByteData> loadAsset() async {
  return await rootBundle.load("assets/poem.txt");
}

Future<String> loadPath() async {
  var filename = "poem.txt";
  var bytes = await rootBundle.load("assets/$filename");
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
  print(
      "${read_file("/data/user/0/com.example.jisho_example/app_flutter/poem.txt")}");
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
          child: FutureBuilder<String>(
            future: loadPath(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //print(snapshot.data);
              return snapshot.hasData
                  ? Text(list_files_in_dir(snapshot.data))
                  //  ? Text(snapshot.data)
                  : CircularProgressIndicator();
            },
          ), //${search(index: "./index", query: "人間")}
        ),
      ),
    );
  }
}
