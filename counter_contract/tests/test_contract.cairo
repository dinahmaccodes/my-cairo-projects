use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

use counter_contract::ICounterContractSafeDispatcher;
use counter_contract::ICounterContractSafeDispatcherTrait;
use counter_contract::ICounterContractDispatcher;
use counter_contract::ICounterContractDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).expect('it is not declaring').contract_class();    
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).expect('counter not deploying');
    contract_address 
} 



#[test]
fn test_initial_contract() {
    let contract_address = deploy_contract("CounterContract");
    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance = dispatcher.get_balance();
    assert(balance == 0, 'Wrong initial balance');
}

#[test]
fn test_increase_balance() {
    let contract_address = deploy_contract("CounterContract");
    let dispatcher = ICounterContractDispatcher { contract_address };
    //check the initial balance 
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount should be zero');
    //increase the balance
    dispatcher.increase_balance(32);
    //check the new balance
    let balance_after = dispatcher.get_balance();
    assert!(balance_after == 32, "Amount can not be this");

}

#[test]
#[should_panic(expected: "Cannot increase by zero")]
fn test_panic_attempt_for_increase_balance_by_zero() {
    let contract_address = deploy_contract("CounterContract");
    let dispatcher = ICounterContractDispatcher { contract_address };
    let balance_before = dispatcher.get_balance();
    assert(balance_before == 0, 'Amount should be zero');
    dispatcher.increase_balance(0);

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

