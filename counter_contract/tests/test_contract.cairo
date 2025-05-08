use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

// use counter_contract::ICounterContract;
// use counter_contract::ICounterContractSafeDispatcherTrait;
// use counter_contract::ICounterContractSafeDispatcher;
use counter_contract::ICounterContractDispatcher;
use counter_contract::ICounterContractDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address 
} 

#[test]
fn test_increase_balance() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(32);
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 32, "Amount can not be zero");

}

#[test]
#[should_panic(expected: "Cannot increase by zero")]
fn test_increase_balance_by_zero() {
    let contract_address = deploy_contract("CounterContract");
    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(0);

}

#[test]
#[should_panic(expected: "amount is wrong")]
fn test_wrong_balance_after_increase_by_value() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(32);
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 20, "New amount is wrong");

}

#[test] 
fn test_increase_balance_by_one() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance_by_one();
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 1, "New amount is wrong");
}

#[test]
#[should_panic(expected: "Amount is not correct")]
fn test_wrong_balance_after_increase_by_one() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance_by_one();
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 13, "Amount is not correct");

}

#[test]
fn test_decrease_balance() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(16);
    dispatcher.decrease_balance(7);
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 9, "Amount can not be this");

}

#[test]
#[should_panic(expected: "Amount can not be zero")]
fn test_wrong_balance_after_decrease_by_value() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(16);
    dispatcher.decrease_balance(4);
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 11, "Amount can not be zero");

}
 
#[test]
fn test_decrease_balance_by_one() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(18);
    dispatcher.decrease_balance_by_one();
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 17, "Amount can not be zero");

}

#[test]
#[should_panic(expected: "Amount can not be zero")]
fn test_wrong_balance_after_decrease_by_one() {
    let contract_address = deploy_contract("CounterContract");

    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount can not be zero');
    dispatcher.increase_balance(9);
    dispatcher.decrease_balance_by_one();
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 11, "Amount can not be zero");

}

// #[test]
// fn test_increase_balance() {
//     let contract_address = deploy_contract("HelloStarknet");

//     let dispatcher = IHelloStarknetDispatcher { contract_address };

//     let balance_before = dispatcher.get_balance();
//     assert(balance_before == 0, 'Invalid balance');

//     dispatcher.increase_balance(42);

//     let balance_after = dispatcher.get_balance();
//     assert(balance_after == 42, 'Invalid balance');
// }

// #[test]
// #[feature("safe_dispat sncast --account my_account \
//     declare \
//     --network sepolia \
//     --contract-name HelloSncast

//     match safe_dispatcher.increase_balance(0) {
//         Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
//         Result::Err(panic_data) => {
//             assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data.at(0));
//         }
//     };
// }