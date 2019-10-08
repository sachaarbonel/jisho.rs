mod search;
use std::ffi::CString;
use std::os::raw::c_char;
use std::path::Path;

#[no_mangle]
pub extern "C" fn search() -> *const c_char {
    // let pathstr = unsafe { CStr::from_ptr(path_ptr) };
    // let querystr = unsafe { CStr::from_ptr(query_ptr) };
    // let directory = Path::new(pathstr.to_str().unwrap());
    // let query = querystr.to_str().unwrap();
    //println!("{:?}", search::search_document(&directory, query));
    let v = search::search_document(Path::new("./index"), "人間");
    let s = CString::new(v).unwrap();
    let p = s.as_ptr();
    std::mem::forget(s);
    p
}
