// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/EIP712SigConsumer.sol";

contract CounterTest is Test {
    EIP712SigConsumer public sigConsumer;

    function setUp() public {
        sigConsumer = new EIP712SigConsumer();
    }

    function testSigGeneratedByViem() public {
        bytes32 viemGeneratedDigest = 0x986b679424ddcb80d097ab20d0cbd0af3f0d935f88627f67bd76251a89a12447;

        EIP712SigConsumer.SubStruct[]
            memory subStructs = new EIP712SigConsumer.SubStruct[](2);

        subStructs[0] = EIP712SigConsumer.SubStruct(address(1), 1);
        subStructs[1] = EIP712SigConsumer.SubStruct(address(2), 2);

        EIP712SigConsumer.MainStruct memory mainStruct = EIP712SigConsumer
            .MainStruct(
                1,
                address(2),
                3,
                address(4),
                EIP712SigConsumer.TypeEnum.TYPE_ONE,
                5,
                6,
                7,
                8,
                subStructs
            );

        (
            bool isValidHashNonRecursive,
            bool isValidHashRecursive,
            bool isValidHashHashedArray,
            bytes32 contractGeneratedNonRecursiveHash,
            bytes32 contractGeneratedRecursiveHash,
            bytes32 contractGeneratedHashedArrayHash
        ) = sigConsumer.isValidHash(mainStruct, viemGeneratedDigest);

        console.log("isValidHashNonRecursive: %s", isValidHashNonRecursive);
        console.log("isValidHashRecursive: %s", isValidHashRecursive);
        console.log("isValidHashHashedArray: %s", isValidHashHashedArray);
        console.logBytes32(contractGeneratedNonRecursiveHash);
        console.logBytes32(contractGeneratedRecursiveHash);
        console.logBytes32(contractGeneratedHashedArrayHash);
    }
}
