mod search;
use std::ffi::CStr;
use std::os::raw::c_char;
use std::path::Path;

#[no_mangle]
pub extern "C" fn search(path_ptr: *const c_char, query_ptr: *const c_char) {
    //-> Vec<String> {
    let pathstr = unsafe { CStr::from_ptr(path_ptr) };
    let querystr = unsafe { CStr::from_ptr(query_ptr) };
    let directory = Path::new(pathstr.to_str().unwrap());
    let query = querystr.to_str().unwrap();
    println!("{:?}", search::search_document(&directory, query));
}
