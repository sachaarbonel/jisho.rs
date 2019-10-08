import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

typedef NativeRustSearchFunction = ffi.Pointer<Utf8> Function(
    ffi.Pointer<Utf8>, ffi.Pointer<Utf8>);

typedef NativeSearchFunction = ffi.Pointer<Utf8> Function(
    ffi.Pointer<Utf8>, ffi.Pointer<Utf8>);
