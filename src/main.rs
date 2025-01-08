// This a sample, derived out of the public sample from rustls public example
// This TLS client will use Post Quantum Crypto
// This is how this (or any) TLS Client will work
// First setup a local cert store
// fill it up with "known" root certs - a good source is Mozilla's Root certs
// https://hg.mozilla.org/releases/mozilla-beta/file/tip/security/nss/lib/ckfw/builtins/certdata.txt
// filter it down to certs that do not need mutual auth
// emable SSLKEYLOGFILE for wireshark debugging later on
// if : You want to decrypt and examine SSL application data using the SSL session key.
//      You want to log the SSL session keys on the client system
//      You are using Firefox or Chrome or Edge browsers client to access web application.
//      https://my.f5.com/manage/s/article/K50557518

// Rust projects are more readable when they stick to the standard project layout, 
// which is auto-detected by Cargo. If you have just one main.rs
// To do this, make your source file have the name src/main.rs 
// instead of src/<your own name>.rs,
// In Cargo.toml just say the name of the package you want
// Leave out the [[bin]] section and path entirely from your Cargo.toml. 
// The built executable will still be named Guessi<your own name>ngGame 
// automatically, because that's your package name.

use std::io::{stdout, Read, Write};
use std::net::TcpStream;
use std::sync::Arc;
use rustls::RootCertStore;

fn main() {
    let root_store = RootCertStore {
        roots: webpki_roots::TLS_SERVER_ROOTS.into(),
    };
    let mut config = rustls::ClientConfig::builder()
        .with_root_certificates(root_store)
        .with_no_client_auth();

    // Allow using SSLKEYLOGFILE.
    config.key_log = Arc::new(rustls::KeyLogFile::new());

    let server_name = "www.rust-lang.org".try_into().unwrap();
    let mut conn = rustls::ClientConnection::new(Arc::new(config), server_name).unwrap();
    let mut sock = TcpStream::connect("www.rust-lang.org:443").unwrap();
    let mut tls = rustls::Stream::new(&mut conn, &mut sock);
    tls.write_all(
        concat!(
            "GET / HTTP/1.1\r\n",
            "Host: www.rust-lang.org\r\n",
            "Connection: close\r\n",
            "Accept-Encoding: identity\r\n",
            "\r\n"
        )
        .as_bytes(),
    )
    .unwrap();
    let ciphersuite = tls
        .conn
        .negotiated_cipher_suite()
        .unwrap();
    writeln!(
        &mut std::io::stderr(),
        "Current ciphersuite: {:?}",
        ciphersuite.suite()
    )
    .unwrap();
//    let mut plaintext = Vec::new();
//    tls.read_to_end(&mut plaintext).unwrap();
//    stdout().write_all(&plaintext).unwrap();
}