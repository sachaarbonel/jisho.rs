import 'dlib.dart' as dl;
import 'types.dart';

NativeSearchFunction Search = dl.rustlib
    .lookupFunction<NativeRustSearchFunction, NativeSearchFunction>("search");

NativeRustSearchImFunction Search_Im = dl.rustlib
    .lookupFunction<NativeRustSearchImFunction, NativeRustSearchImFunction>(
        "search_im");
