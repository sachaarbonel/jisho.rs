import 'dlib.dart' as dl;
import 'types.dart';

NativeSearchFunction Search = dl.rustlib
    .lookupFunction<NativeRustSearchFunction, NativeSearchFunction>("search");

NativeRustSearchImFunction Search_Im = dl.rustlib
    .lookupFunction<NativeRustSearchImFunction, NativeRustSearchImFunction>(
        "search_im");

NativeRustReadfileFunction Readfile = dl.rustlib
    .lookupFunction<NativeRustReadfileFunction, NativeRustReadfileFunction>(
        "read_file");
NativeRustReadfileFunction ListFiles = dl.rustlib
    .lookupFunction<NativeRustReadfileFunction, NativeRustReadfileFunction>(
        "list_files_in_dir");
