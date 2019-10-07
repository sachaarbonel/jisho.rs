import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NativeRustPlayOnceFunction = ffi.Void Function(
    ffi.Pointer<Utf8>, ffi.Pointer<Utf8>); //ffi.Pointer<ffi.Pointer<Utf8>>
typedef NativePlayOnceFunction = void Function();

main() {
  ffi.DynamicLibrary dl = ffi.DynamicLibrary.open("target/debug/libjisho.so");
  var search =
      dl.lookupFunction<NativeRustPlayOnceFunction, NativeRustPlayOnceFunction>(
          "search");
  final Pointer<Utf8> index = Utf8.toUtf8("./index").cast();
  final Pointer<Utf8> query = Utf8.toUtf8("人間").cast();
  search(index, query);
}
