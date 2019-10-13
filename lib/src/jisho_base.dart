import 'bindings.dart' as bd;
import 'package:ffi/ffi.dart';
import 'dart:ffi' as ffi;

String search({String index, String query}) {
  final ffi.Pointer<Utf8> idx = Utf8.toUtf8(index).cast();
  final ffi.Pointer<Utf8> q = Utf8.toUtf8(query).cast();
  return Utf8.fromUtf8(bd.Search(idx, q));
}

String search_im({String query}) {
  final ffi.Pointer<Utf8> q = Utf8.toUtf8(query).cast();
  return Utf8.fromUtf8(bd.Search_Im(q));
}

String read_file(String filename) {
  final ffi.Pointer<Utf8> file = Utf8.toUtf8(filename).cast();
  return Utf8.fromUtf8(bd.Readfile(file));
}

String list_files_in_dir(String filename) {
  final ffi.Pointer<Utf8> file = Utf8.toUtf8(filename).cast();
  return Utf8.fromUtf8(bd.ListFiles(file));
}
