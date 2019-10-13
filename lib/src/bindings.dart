import 'dlib.dart' as dl;
import 'types.dart';

NativeRustSearchFunction Search = dl.rustlib
    .lookupFunction<NativeRustSearchFunction, NativeRustSearchFunction>(
        "search");
