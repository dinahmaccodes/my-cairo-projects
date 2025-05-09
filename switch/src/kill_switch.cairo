/// Interface representing `HelloContract`.
/// This interface allows modification and retrieval of the contract balance.
pub mod KillSwitch;
#[starknet::interface]
pub trait IHelloStarknet<TContractState> {
    fn switch(ref self: TContractState, amount: felt252);

    /// Retrieve switch status
    fn get_status(self: @TContractState) -> felt252;
}

/// Simple contract for managing balance.
#[starknet::contract]
mod KillSwitch {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use crate::IHelloStarknet;

    #[storage]
    struct Storage {
        balance: felt252,
    }

    #[abi(embed_v0)]
    impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
        fn switch(ref self: ContractState, amount: felt252) {
            assert(amount != 0, 'Amount cannot be 0');
            self.balance.write(self.balance.read() + amount);
        }


        fn get_status(self: @ContractState) -> felt252 {
            self.balance.read()
        }
    }
}
