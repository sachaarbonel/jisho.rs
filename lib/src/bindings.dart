import 'dlib.dart' as dl;
import 'types.dart';

NativeSearchFunction Search = dl.rustlib
    .lookupFunction<NativeRustSearchFunction, NativeSearchFunction>("search");
