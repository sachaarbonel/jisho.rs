import 'dart:ffi' as ffi;

ffi.DynamicLibrary rustlib = () {
  ffi.DynamicLibrary dl = ffi.DynamicLibrary.open("libjisho.so");
  return dl;
}();
