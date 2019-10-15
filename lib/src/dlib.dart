import 'dart:ffi' as ffi;
import 'dart:io';

ffi.DynamicLibrary rustlib = () {
  ffi.DynamicLibrary dl = Platform.isAndroid
    ? ffi.DynamicLibrary.open("libjisho.so")
    : ffi.DynamicLibrary.open("jisho.framework/jisho");
  return dl;
}();
