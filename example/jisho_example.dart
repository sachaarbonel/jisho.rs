import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

typedef NativeRustPlayOnceFunction = ffi.Pointer<Utf8> Function();

main() {
  ffi.DynamicLibrary dl = ffi.DynamicLibrary.open("target/debug/libjisho.so");
  var search =
      dl.lookupFunction<NativeRustPlayOnceFunction, NativeRustPlayOnceFunction>(
          "search");
  // final Pointer<Utf8> index = Utf8.toUtf8("./index").cast();
  // final Pointer<Utf8> query = Utf8.toUtf8("人間").cast();
  print(Utf8.fromUtf8(search())); //query, index
}
