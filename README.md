# rust-build
this one will build from another local Jenkins instance first
Building Rust needs a bit more background on some fundamentals
<petpeeve> - when you learn a new language - most try to get you to write a program that executes first, rather than fundamentals. So one starts to learn somethinggs, and creates an abstract understanding of the fundamentals all the way through learning complex construcuts. Then one day when the person sits down to start producing something for the real world, they find out they have zero idea of the fundamentals, and its the most irritating thing during a learning experience. </petpeeve>

Anyhow the first you should have known :
The smallest "unit" of code - from the context of organizing code - is a "Crate"

All Crates have a "Crate root" - i.e. where the compiler will start looking
**"Usually"** src/lib.rs for a library crate or src/main.rs for a binary crate

[hint - if you want the compiler to look elsewhere you have to ask it to - using TOML]

A collection of crates is called a "Package" - one cargo new <package-name> builds one package with one crate binary by default.

** Rules 1 Package = 1 to n Binary crates + Only 1 Library Crate **
