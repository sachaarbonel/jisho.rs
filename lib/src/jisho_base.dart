import 'dart:io';

import 'package:flutter/material.dart';

import 'bindings.dart' as bd;
import 'package:ffi/ffi.dart';
import 'dart:ffi' as ffi;

import 'dart:async' show Completer, Future;
import 'package:flutter/services.dart' show ByteData;
import 'package:path_provider/path_provider.dart';

Future<String> loadFile(BuildContext context, String filename,
    {String directory, String package}) async {
  var bytes = await _loadBytes(context, package, directory, filename);
  String currentPath = await _getCurrentPath();
  await _writeToFile(bytes,
      path: currentPath,
      filename: filename,
      directory: directory,
      package: package);
  return currentPath;
}

Future<String> _getCurrentPath() async =>
    (await getApplicationDocumentsDirectory()).path;

Future<ByteData> _loadBytes(BuildContext context, String package,
    String directory, String filename) async {
  return await DefaultAssetBundle.of(context)
      .load("packages/$package/$directory/$filename");
}

Future<String> loadFiles(BuildContext context, List<String> filenames,
    {String directory, String package}) async {
  String currentPath = await _getCurrentPath();
  await Future.wait(filenames.map((filename) async {
    final bytes = await _loadBytes(context, package, directory, filename);
    await _writeToFile(bytes,
        path: currentPath,
        filename: filename,
        directory: directory,
        package: package);
  }));

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

Future<String> loadIndex(BuildContext context) async {
  return await loadFiles(
      context,
      [
        "080d0121166f4c8e98bf4fb0d90b272f.fieldnorm",
        //".tantivymeta.lock",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.posidx",
        "080d0121166f4c8e98bf4fb0d90b272f.pos",
        "84f0f68190f249ba825ddac8fcff2547.fast",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.fast",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.pos",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.idx",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.term",
        ".managed.json",
        "84f0f68190f249ba825ddac8fcff2547.store",
        "080d0121166f4c8e98bf4fb0d90b272f.posidx",
        "84f0f68190f249ba825ddac8fcff2547.fieldnorm",
        "84f0f68190f249ba825ddac8fcff2547.idx",
        "meta.json",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.store",
        "84f0f68190f249ba825ddac8fcff2547.term",
        "1c2b8aa1fb5b4ede95f3df7d70f8db2c.fieldnorm",
        //   ".tantivywriter.lock",
        "080d0121166f4c8e98bf4fb0d90b272f.term",
        "84f0f68190f249ba825ddac8fcff2547.posidx",
        "84f0f68190f249ba825ddac8fcff2547.pos",
        "080d0121166f4c8e98bf4fb0d90b272f.idx",
        "080d0121166f4c8e98bf4fb0d90b272f.fast",
        "080d0121166f4c8e98bf4fb0d90b272f.store"
      ],
      package: "jisho",
      directory: "index");
}

String search({String index, String query}) {
  final ffi.Pointer<Utf8> idx = Utf8.toUtf8(index).cast();
  final ffi.Pointer<Utf8> q = Utf8.toUtf8(query).cast();
  return Utf8.fromUtf8(bd.Search(idx, q));
}
