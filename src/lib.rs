mod search;
use std::ffi::CStr;
use std::ffi::CString;
use std::os::raw::c_char;
use std::path::Path;

#[no_mangle]
pub extern "C" fn search(index_ptr: *const c_char, query_ptr: *const c_char) -> *const c_char {
    let indexstr = unsafe { CStr::from_ptr(index_ptr) };
    let querystr = unsafe { CStr::from_ptr(query_ptr) };
    let index = Path::new(indexstr.to_str().unwrap());
    let query = querystr.to_str().unwrap();
    let v = search::search_document(index, query);
    let s = CString::new(v).unwrap();
    let p = s.as_ptr();
    std::mem::forget(s);
    p
}

#[no_mangle]
pub extern "C" fn read_file(filename_ptr: *const c_char) -> *const c_char {
    let filenamestr = unsafe { CStr::from_ptr(filename_ptr) };
    let v = search::read_file(filenamestr.to_str().unwrap());
    let s = CString::new(v).unwrap();
    let p = s.as_ptr();
    std::mem::forget(s);
    p
}

#[no_mangle]
pub extern "C" fn list_files_in_dir(filename_ptr: *const c_char) -> *const c_char {
    let filenamestr = unsafe { CStr::from_ptr(filename_ptr) };
    let v = search::list_files_in_dir(filenamestr.to_str().unwrap());
    let s = CString::new(v).unwrap();
    let p = s.as_ptr();
    std::mem::forget(s);
    p
}

#[no_mangle]
pub extern "C" fn search_im(query_ptr: *const c_char) -> *const c_char {
    let querystr = unsafe { CStr::from_ptr(query_ptr) };
    let query = querystr.to_str().unwrap();
    let v = search::search_document_im(query);
    let s = CString::new(v).unwrap();
    let p = s.as_ptr();
    std::mem::forget(s);
    p
}

#[no_mangle]
pub extern "C" fn string_from_rust() -> *const u8 {
    "Hello World".as_ptr()
}

#[no_mangle]
pub extern "C" fn rust_add(a: i32, b: i32) -> i32 {
    a + b
}
