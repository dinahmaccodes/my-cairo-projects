## Functions in simple_cairo_ones

1. `hello_world`: Prints a simple "Hello world" message to verify output and setup.
2. `num`:
- Declares and prints unsigned integers (u8, u32).
- Demonstrates assert checks for value correctness.
3. `args`:
- Shows how to pass multiple arguments to a function.
- Prints two numbers (first_arg, second_arg).
4. `if_func`:
- Basic if/else logic based on a boolean flag.
5. `if_complex`:
- Uses multiple condition checks and logical operators (&&, ||) to control the flow.
- Prints different messages based on the combination of values.
6. `str`:
- Declares and prints short strings (Cairo allows up to 31 characters).
- Strings are printed as felt252 values.
- Includes an assert to verify the string value.
7. `felt`:
- Demonstrates large integer usage (felt252), which can hold values up to 
2^252 − 1 
- Shows modular arithmetic behavior in Cairo.
- Uses assert to illustrate Cairo’s modulus logic.