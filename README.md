# Move Smart Contract: `Bets` Module

This repository contains a Move smart contract module named `Bets`, which allows users to initialize, deposit, withdraw, and transfer APT tokens. The module also provides a function to check the balance of an account.

## Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
3. [Compiling the Smart Contract](#compiling-the-smart-contract)
4. [Testing the Smart Contract](#testing-the-smart-contract)
5. [Module Functions](#module-functions)
6. [Test Cases](#test-cases)
7. [License](#license)

---

## Overview

The `Bets` module is a Move smart contract that provides the following functionality:

- **Initialize**: Initialize an account with an `AptBalance` resource.
- **Deposit**: Deposit APT tokens into an account.
- **Withdraw**: Withdraw APT tokens from an account.
- **Transfer**: Transfer APT tokens from one account to another.
- **Balance Check**: Check the balance of an account.

The module is designed to be secure and efficient, leveraging Move's resource-oriented programming model.

---

## Getting Started

## Smart Contract (Move)

### Module: `betpool::Bets`

### **Initialize Account**

```move
public entry fun initialize(account: &signer)
```

- Ensures the account does not already have a balance.
- Sets initial balance to 0.

### **Deposit Tokens**

```move
public entry fun deposit(account: &signer, amount: u64) acquires AptBalance
```

- Increases the balance by the deposited amount.

### **Withdraw Tokens**

```move
public entry fun withdraw(account: &signer, amount: u64) acquires AptBalance
```

- Ensures the user has enough balance before withdrawal.
- Deducts the withdrawn amount from the balance.

### **Check Balance**

```move
public fun balance_of(account_addr: address): u64 acquires AptBalance
```

- Returns the balance of the specified account.

### **Transfer Tokens**

```move
public fun transfer(from: &signer, to: address, amount: u64) acquires AptBalance
```

- Ensures the sender has sufficient funds.
- Deducts the amount from sender and credits the receiver.

---

## Unit Testing (Move)

### Module: `betpool::BetsTest`

The test module verifies the functionality of the `Bets` contract.

### **Test Cases:**

- ``: Ensures an account is initialized with zero balance.
- ``: Deposits tokens and verifies the new balance.
- ``: Withdraws tokens and verifies the balance reduction.
- ``: Checks if the correct balance is returned.
- ``: Transfers tokens between two accounts and verifies balances.

### **Run Tests**

To execute the unit tests, use:

```sh
aptos move test
```

---

## Deployment

### **Compile the Module**

```sh
aptos move compile
```

### **Deploy the Module**

```sh
aptos move publish --profile default
```

### **Run Functions**

Example: Deposit 10 APT tokens

```sh
aptos move run --function-id <MODULE_ADDRESS>::Bets::deposit --args u64:10
```

