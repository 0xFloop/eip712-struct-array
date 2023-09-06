// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/EIP712SigConsumer.sol";

contract CounterTest is Test {
    EIP712SigConsumer public sigConsumer;

    function setUp() public {
        sigConsumer = new EIP712SigConsumer();
    }

    function testSigGeneratedByViem() public view {
        bytes32 viemGeneratedDigest = 0x3ae6c97d5e563102b38c8b189cbce739cb9cbc49144edd23cbd6ff0a3dfd6d91;

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

        (bool isValidHash, bytes32 hash) = sigConsumer.isValidHash(
            mainStruct,
            viemGeneratedDigest
        );

        console.log("isValidHash: %s", isValidHash);
        console.logBytes32(hash);
    }
}
