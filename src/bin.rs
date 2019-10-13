// mod search;
// use search::index_document;
// use std::path::Path;
use std::fs;
use std::fs::File;
use std::io::Read;
use std::path::Path;

fn read_file(filename: &str) -> String {
    let path = Path::new(filename);
    let mut file = File::open(&path).unwrap();
    let mut buffer = String::new();
    file.read_to_string(&mut buffer).unwrap();
    buffer
}

fn list_files_in_dir(filename: &str) -> String {
    let path = Path::new(filename);
    let paths = dbg!(fs::read_dir(path)).unwrap();

    let results = paths
        .map(|path| dbg!(dbg!(path).unwrap().path().into_os_string().into_string()).unwrap())
        .collect::<Vec<String>>();
    results.join("\n")
}

fn main() {
    println!("{}", list_files_in_dir("./lib/assets/index"));
}
