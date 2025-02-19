// apt_token_storage.move

module betpool::Bets {
    use std::signer;
    // use aptos_framework::aptos_coin::AptosCoin;
     use aptos_framework::aptos_account;
    // use aptos_framework::coin;

    // Struct to store the balance of APT tokens for each user
    struct AptBalance has key {
        balance: u64,
    }

    // Initialize the module
    public entry fun initialize(account: &signer) {
        // Ensure the account doesn't already have a balance
        assert!(!exists<AptBalance>(signer::address_of(account)), 1001);

        // Initialize the balance to 0
        move_to(account, AptBalance { balance: 0 });
    }

    // Deposit APT tokens into the account
    public entry fun deposit(account: &signer, amount: u64) acquires AptBalance {
        // Check if the account has a balance
        assert!(exists<AptBalance>(signer::address_of(account)), 1002);

        // Get the balance of the account
        let balance = borrow_global_mut<AptBalance>(signer::address_of(account));

        // Increase the balance by the deposited amount
        aptos_account::transfer(account,@betpool,amount);
        //balance.balance = balance.balance + amount;
    }

    //Withdraw APT tokens from the account
    public entry fun withdraw(account: &signer, amount: u64) acquires AptBalance {
        // Check if the account has a balance
        assert!(exists<AptBalance>(signer::address_of(account)), 1002);

        // Get the balance of the account
        let balance = borrow_global_mut<AptBalance>(signer::address_of(account));

          // Increase the balance by the deposited amount
       // aptos_account::transfer(@betpool,account,amount);

        // Ensure the account has enough balance to withdraw
        assert!(balance.balance >= amount, 1003);

        // Decrease the balance by the withdrawn amount
        balance.balance = balance.balance - amount;
    }

    // Public function to check the balance of a specific address
    // #[view]
    // public fun balance_of(account_addr: address): u64 acquires AptBalance {
    //     // Check if the account has a balance
    //     assert!(exists<AptBalance>(account_addr), 1002);

    //     // Get the balance of the account
    //     //let balance = aptos_account::balance_of(@storage);

    //     // Return the balance
    //     //balance.balance
    // }

    //Transfer APT tokens from one account to another
    public fun transfer(from: &signer, to: address, amount: u64) acquires AptBalance {
        // Check if the sender has a balance
        assert!(exists<AptBalance>(signer::address_of(from)), 1002);

        // Get the balance of the sender
        let from_balance = borrow_global_mut<AptBalance>(signer::address_of(from));

        // Ensure the sender has enough balance to transfer
        assert!(from_balance.balance >= amount, 1003);

        // Decrease the sender's balance
        from_balance.balance = from_balance.balance - amount;

        // Check if the receiver has a balance
        if (!exists<AptBalance>(to)) {
            // Initialize the receiver's balance if it doesn't exist
            move_to(from, AptBalance { balance: 0 });
        };

        // Get the balance of the receiver
        let to_balance = borrow_global_mut<AptBalance>(to);

        // Increase the receiver's balance
        to_balance.balance = to_balance.balance + amount;
    }
}