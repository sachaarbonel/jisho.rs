mod search;
use search::index_document;
use std::path::Path;

fn main() {
    let directory = Path::new("./index");
    index_document(&directory);
}
