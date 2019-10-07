mod search;
use std::ffi::CStr;
use std::os::raw::c_char;
use std::path::Path;

#[no_mangle]
pub extern "C" fn search(ptr: *const c_char) {
    //-> Vec<String> {
    let cstr = unsafe { CStr::from_ptr(ptr) };
    let directory = Path::new(cstr.to_str().unwrap());
    println!("{:?}", search::search_document(&directory, "人間"));
}
