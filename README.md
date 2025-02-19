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

### Prerequisites

Before you begin, ensure you have the following installed:

- [Move CLI](https://github.com/move-language/move): The Move command-line interface for compiling and testing
