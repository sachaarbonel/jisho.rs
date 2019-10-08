import 'package:flutter/material.dart';
//import 'package:jisho/jisho.dart';

import 'dart:ffi' as ffi;

typedef NativeRustAddFunction = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef NativeAddFunction = int Function(int, int);

void main() {
  ffi.DynamicLibrary dl = ffi.DynamicLibrary.open("libjisho.so");
  var add =
      dl.lookupFunction<NativeRustAddFunction, NativeAddFunction>("rust_add");
  var number = add(12, 13);
  print("call rust function add(12,13)=$number");
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
