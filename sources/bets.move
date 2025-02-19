// apt_token_storage.move

module betpool::Bets {
    use std::signer;
    use std::unit_test;
    use aptos_framework::aptos_account;
    use std::vector;

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
        //aptos_account::transfer(account,@betpool,amount);

        balance.balance = balance.balance + amount;
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
    #[view]
    public fun balance_of(account_addr: address): u64 acquires AptBalance {
        // Check if the account has a balance
        assert!(exists<AptBalance>(account_addr), 1002);

        // Get the balance of the account
        let balance = borrow_global<AptBalance>(account_addr);

        // Return the balance
        balance.balance
    }

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

       fun get_account(): signer {
        vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

      fun get_account2(): signer {
        vector::pop_back(&mut unit_test::create_signers_for_testing(2))
    } 


  // Test case for `initialize`
    #[test]
    fun test_initialize() acquires AptBalance {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account
        initialize(&account);

        // Verify that the AptBalance resource exists and has a balance of 0
        assert!(exists<AptBalance>(addr), 1);
        assert!(balance_of(addr) == 0, 2);
    }

    // Test case for `deposit`
    #[test]
    fun test_deposit() acquires AptBalance {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account
         initialize(&account);

        // Deposit 100 tokens
         deposit(&account, 100);

        // Verify that the balance is 100
        assert!(balance_of(addr) == 100, 3);
    }

    // Test case for `withdraw`
    #[test]
    fun test_withdraw() acquires AptBalance {
        let account = get_account();
  let addr = signer::address_of(&account);
        // Initialize the account and deposit 100 tokens
   initialize(&account);
        deposit(&account, 100);

        // Withdraw 50 tokens
        withdraw(&account, 50);

        // Verify that the balance is 50
        assert!(balance_of(addr) == 50, 4);
    }

    // Test case for `balance_of`
    #[test]
    fun test_balance_of() acquires AptBalance {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account and deposit 200 tokens
   initialize(&account);
        deposit(&account, 200);

        // Verify that the balance is 200
        assert!(balance_of(addr) == 200, 5);
    }

    // Test case for `transfer`
    #[test]
    fun test_transfer() acquires AptBalance {
        let account1 = get_account();
        let addr1 = signer::address_of(&account1);
        let account2 = get_account2();
        let addr2 = signer::address_of(&account2);

        // Initialize both accounts
        initialize(&account1);
        initialize(&account2);

        // Deposit 300 tokens into account1
        deposit(&account1, 300);

        // Transfer 100 tokens from account1 to account2
        transfer(&account1, addr2, 100);

        // Verify the balances
        assert!(balance_of(addr1) == 200, 6); // 300 - 100 = 200
        assert!(balance_of(addr2) == 100, 7); // 0 + 100 = 100
    }


}