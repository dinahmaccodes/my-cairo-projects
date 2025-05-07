// Modification of the contract's balance 

#[starknet::interface]
pub trait ICounterContract<TContractState> {
    //Increase the counter balance
    fn increase_balance(ref self: TContractState, amount: u256);

    //Increase by one 
    fn increase_balance_by_one(ref self: TContractState);

    //Decrease the counter balance 
    //However, add a check for underflow so balance should not be less than 0 
    fn decrease_balance(ref self: TContractState, amount: u256);

    //Decrease by one
    fn decrease_balance_by_one(ref self: TContractState);

    //Get counter balance 
    fn get_balance(self: @TContractState) -> u256;

    //Reset counter balance 
    fn reset_balance(ref self: TContractState, amount: u256);
}

#[starknet::contract]
mod CounterContract {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};


    #[storage]
    struct Storage {
        balance: u256,
    }


    #[abi(embed_v0)]
    impl CounterContractImpl of super::ICounterContract<ContractState> {

        fn increase_balance(ref self: ContractState, amount: u256) {
            assert!(amount > 0, "Cannot increase by zero?" );
            self.balance.write(self.balance.read() + amount);

        } 
        fn increase_balance_by_one(ref self: ContractState) {
            self.balance.write(self.balance.read() + 1);
        }

        fn decrease_balance(ref self: ContractState, amount: u256  ) {
            assert(amount > 0, 'Amount can not be zero');
            assert!(self.balance.read() > 0, "Balance can not be less than zero");
            self.balance.write(self.balance.read() - amount);
        }

        fn decrease_balance_by_one(ref self: ContractState) {
            self.balance.write(self.balance.read() - 1);
        }

        fn get_balance(self: @ContractState) -> u256 {
            self.balance.read()
        }

        fn reset_balance(ref self: ContractState, amount: u256) {
            self.balance.write(0);

        }

    }
}

