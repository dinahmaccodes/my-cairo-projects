
use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

use cairo_2::IHelloStarknetSafeDispatcher;
use cairo_2::IHelloStarknetSafeDispatcherTrait;
use cairo_2::IHelloStarknetDispatcher;
use cairo_2::IHelloStarknetDispatcherTrait;

// deploy util function
fn __deploy__() -> ContractAddress {
    let contract_name: ByteArray = "HelloStarknet";
    let contract = declare(contract_name).expect('e no gree declare').contract_class();
    // let contract = declare(name).unwrap().contract_class();
    let calldata: Array<felt252> = array![];
    let calldata_2: Array<felt252> = ArrayTrait::new();
    // let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    let (contract_address, _) = contract.deploy(@calldata_2).expect('e gree deploy');
    contract_address
}

#[test]
fn test_increase_balance() {
    let contract_address = __deploy__();

    let dispatcher = IHelloStarknetDispatcher { contract_address };

    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Invalid balance');

    dispatcher.increase_balance(42);

    let balance_after = dispatcher.get_balance();
    assert(balance_after == 42, 'Invalid balance');
}

#[test]
#[feature("safe_dispatcher")]
fn test_cannot_increase_balance_with_zero_value() {
    let contract_address = __deploy__();

    let safe_dispatcher = IHelloStarknetSafeDispatcher { contract_address };

    let balance_before = safe_dispatcher.get_balance().unwrap();
    assert(balance_before == 0, 'Invalid balance');

    match safe_dispatcher.increase_balance(0) {
        Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
        Result::Err(panic_data) => {
            // assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data.at(0));
            assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data[0]);
        }
    };
}

#[test]
// #[feature("safe_dispatcher")]
#[should_panic(expect: 'Amount cannot be 0')]
fn test_panic_attempt_to_increase_balance_with_zero_value() {
    let contract_address = __deploy__();

    let dispatcher = IHelloStarknetDispatcher { contract_address };

    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Invalid balance');

    dispatcher.increase_balance(0);
    
}


#[test]
fn test_decrease_balance() {
    let contract_address = __deploy__();

    let dispatcher = IHelloStarknetDispatcher { contract_address };

    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Invalid balance');

    dispatcher.increase_balance(22);
    dispatcher.decrease_balance_by_one();
    let balance_after = dispatcher.get_balance();
    assert(balance_after == 21, 'Invalid balance');
}

#[test]
#[should_panic(expect: 'Amount cannot be 0')]
fn test_panic_attempt_to_decrease_zero_balance() {
    let contract_address = __deploy__();

    let dispatcher = IHelloStarknetDispatcher { contract_address };

    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Invalid balance');

    dispatcher.decrease_balance_by_one();
}


#[test]
#[feature("safe_dispatcher")]
fn test_cannot_decrease_balance_with_zero_value() {
    let contract_address = __deploy__();

    let safe_dispatcher = IHelloStarknetSafeDispatcher { contract_address };

    let balance_before = safe_dispatcher.get_balance().unwrap();
    assert(balance_before == 0, 'Invalid balance');

    match safe_dispatcher.decrease_balance_by_one() {
        Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
        Result::Err(panic_data) => {
            assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data[0]);
        }
    };
}


// use starknet::ContractAddress;

// use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

// use cairo_2::IHelloStarknetSafeDispatcher;
// use cairo_2::IHelloStarknetSafeDispatcherTrait;
// use cairo_2::IHelloStarknetDispatcher;
// use cairo_2::IHelloStarknetDispatcherTrait;

//     fn deploy_contract(name: ByteArray) -> ContractAddress {
//     let contract = declare(name).unwrap().contract_class(); 
//     let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
//     contract_address
// }

// #[test] 

//     fn test_increase_balance() {
//     let contract_address = deploy_contract("HelloStarknet");

//     let dispatcher =  IHelloStarknetDispatcher { contract_address };

//     let balance_before = dispatcher.get_balance();
//     assert(balance_before == 0, 'Invalid balance'); 

//     dispatcher.increase_balance(42);

//     let balance_after = dispatcher.get_balance();
//     assert(balance_after == 42, 'Invalid balance');
// }

// #[test]
// #[feature("safe_dispatcher")]
// fn test_cannot_increase_balance_with_zero_value() {
//     let contract_address = deploy_contract("HelloStarknet");

//     let safe_dispatcher = IHelloStarknetSafeDispatcher { contract_address };

//     let balance_before = safe_dispatcher.get_balance().unwrap();
//     assert(balance_before == 0, 'Invalid balance');

//     match safe_dispatcher.increase_balance(0) {
//         Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
//         Result::Err(panic_data) => {
//             assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data.at(0));
//         }
//     };
// }


