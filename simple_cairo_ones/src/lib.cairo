const HOUR_TO_SECONDS: u32 = 3600;
const MINUTE_TO_SECONDS: u32 = 60; 


fn main() {
    hello_world();
    num();
    var();
    args();
    if_func();
    if_complex();
    str();
    felt();
    loo();
    cons();
}
//hello world
fn hello_world() {
    println!("Hello world");
}
//dealing with numbers
fn num() {
    let x = 32_u8;
    let y = 4_000_000_u32;
    println!("The number for today is {} and {}", x, y);
    assert(x == 32, 'x is incorrect');
    assert(y == 4_000_000, 'y is incorrect');
}
//mutable and immutable variables
fn var() {
    let imm_var: felt252 = 32;
    let mut mut_var: felt252 = imm_var;
    mut_var = 64;
    println!("The mutable variable is {}", mut_var);
    assert(mut_var != imm_var, 'mutable and immutable are same')
}
//function with arguments
fn num1(a: u8) -> u8 {
    a + 10
}

//how I'm trying to work on it in main but not fully getting it
// let a = 10;
// let b = num1(a);
// println!("num1 is: {}", b);

//function with multiple arguments
fn args() {
    let first_arg = 9;
    let second_arg = 12;
    println!("The arguments are {} and {}", first_arg, second_arg);
}

fn if_func() {
    let is_cool = false;
    if is_cool {
        println!("This is cool");
    } else {
        println!("This is not cool");
    }
}

fn if_complex() {
    let ver: u8 = 0;
    let is_amazing = true;
    //If at least one of the terms, fulfils the condution and the condition is true
    //the if statement, follows as true and fulfils the first condition
    //if both are false, then it fails and moves onto the program after else
    // || - or, the statements above are for or  ||
    // but if i switch it to && - and, both terms need to be fulfilled
    // you can play with it if you like
    if is_amazing && ver > 0 {
        println!("Lets do some coding!");
    } else {
        println!("Have patience, great things are coming");
    }
}
//strings can be a maximum of 31 characters
fn str() {
    //NB: Cairo prints strings as a single big number,
    //so printing it as a felt252 - a big interger
    let s = 'Testing_Strings';
    println!("What are we doing? {}", s);
    assert(s == 'Testing_Strings', 'String is incorrect');
}

fn felt() {
    //felts are long values, can hold almost any data type in cairo except u256
    //felts are 252 bits long, so they can hold a number up to 2^252 - 1
    //felts are used to represent integers in Cairo
    let f: felt252 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let o: felt252 = 1;
    assert(f + o == 0, 'P == 0 (mod P)');
    // The assertion wants it to be zero, 0
    //this is because if you add an extra value, it becomes too big for the range of felt252
    println!("Your felt is: {}", f);
    println!("Your other felt is: {}", o);
}

fn loo() -> u128 {
    let mut lo: u128 = 0;
    loop {
        if lo > 10 {
            break;
        }
        println!("Looping done {}", lo);
        lo = lo + 1;
    }
    lo
}

fn cons() {
    //constants store values that cannot be changed 
    //they store immutable variables
    println!("The first constant is: {}", HOUR_TO_SECONDS);
    println!("The second constant is: {}", MINUTE_TO_SECONDS);
}
//basic attempt at testing
// #[test]
// fn test_num() {
//     num();
// }
// #[test]
// fn test_var() {
//     var();

// }


