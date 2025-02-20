#[test_only]
module betpool::BetsTest {
    use std::signer;
    use betpool::Bets;
    use std::unit_test;
    use std::vector;

   fun get_account(): signer {
        vector::pop_back(&mut unit_test::create_signers_for_testing(1))
    }

      fun get_account2(): signer {
        vector::pop_back(&mut unit_test::create_signers_for_testing(2))
    } 


    // Test case for `initialize`
    #[test]
    fun test_initialize() {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account
        Bets::initialize(&account);

        // Verify that the AptBalance resource exists and has a balance of 0
        //assert!(exists<Bets::AptBalance>(addr), 1);
        assert!(Bets::balance_of(addr) == 0, 2);
    }

    // Test case for `deposit`
    #[test]
    fun test_deposit() {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account
         Bets::initialize(&account);

        // Deposit 100 tokens
         Bets::deposit_bet_amount(&account, 100);

        // Verify that the balance is 100
        assert!(Bets::balance_of(addr) == 100, 3);
    }

    // Test case for `withdraw`
    #[test]
    fun test_withdraw() {
        let account = get_account();
  let addr = signer::address_of(&account);
        // Initialize the account and deposit 100 tokens
   Bets::initialize(&account);
        Bets::deposit_bet_amount(&account, 100);

        // Withdraw 50 tokens
        Bets::withdraw_bet(&account, 50);

        // Verify that the balance is 50
        assert!(Bets::balance_of(addr) == 50, 4);
    }

    // Test case for `balance_of`
    #[test]
    fun test_balance_of() {
        let account = get_account();
        let addr = signer::address_of(&account);
        // Initialize the account and deposit 200 tokens
   Bets::initialize(&account);
        Bets::deposit_bet_amount(&account, 200);

        // Verify that the balance is 200
        assert!(Bets::balance_of(addr) == 200, 5);
    }

    // Test case for `transfer`
    #[test]
    fun test_transfer() {
        let account1 = get_account();
        let addr1 = signer::address_of(&account1);
        let account2 = get_account2();
        let addr2 = signer::address_of(&account2);

        // Initialize both accounts
        Bets::initialize(&account1);
        Bets::initialize(&account2);

        // Deposit 300 tokens into account1
        Bets::deposit_bet_amount(&account1, 300);

        // Transfer 100 tokens from account1 to account2
        Bets::transfer_to_winner(&account1, addr2, 100);

        // Verify the balances
        assert!(Bets::balance_of(addr1) == 200, 6); // 300 - 100 = 200
        assert!(Bets::balance_of(addr2) == 100, 7); // 0 + 100 = 100
    }
}