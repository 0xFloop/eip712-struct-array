# eip712-struct-array
Testing repo for debugging how to properly encode and hash a message that contains a struct array in accordance to EIP712 using Viem.

### Setup
Viem Setup
1. clone repo: `git clone https://github.com/0xFloop/eip712-struct-array.git`
2. cd into the viem folder: `cd eip712-struct-array/viemTest`
3. install dep: `npm install`
4. run viem script: `npm run start`
5. copy the hash that is console.logged out

Sol Setup \n
1. cd to root: `cd ../`
2. open `~/test/EIP712SigConsumer.t.sol` and paste the copied viem generated hash into the `viemGeneratedDigest` on line 15
3. run `forge test -v`

## EIP712SigConsumer.sol
This contract operates as a simple EIP712 sig consumer. 

### hashStruct(MainStruct)
This function hashes the `SubStruct[]` in accordance to EIP712. Essentially using `hashStruct` on all the indices of the `SubStruct[]` and then hashing them all together.


### isValidHash(MainStruct, ViemHash)
This function compares a hash `ViemHash` generate using viem to that which is generated by the hashStruct function in the contract and checks if they match.

## EIP712SigConsumer.t.sol

### testSigGeneratedByViem()
This is the test to check your viem hash vs that generated in the contract. Just save the viem hash to the `viemGeneratedDigest` var on line 15 to test.

## /viemTest
This folder contains simple script for generating a EIP712 hash using viems hashTypedData

## Note
The eip712 domains in Viem and in the Sol both use static data for the comparison, namely the chain id and the verifyingContract address
