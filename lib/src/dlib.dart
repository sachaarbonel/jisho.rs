import 'dart:ffi' as ffi;

ffi.DynamicLibrary rustlib = () {
  ffi.DynamicLibrary dl = ffi.DynamicLibrary.open("target/debug/libjisho.so");
  return dl;
}();
