// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EIP712SigConsumer {
    bytes32 constant MAINSTRUCT_TYPEHASH =
        keccak256(
            "MainStruct(uint256 _one,address _two,uint256 _three,address _four,uint8 typeEnum,uint256 _five,uint256 _six,uint256 _seven,uint256 _eight,SubStruct[] subStructs)SubStruct(address _foo,uint256 _bar)"
        );

    bytes32 constant SUBSTRUCT_TYPEHASH =
        keccak256("SubStruct(address _foo,uint256 _bar)");

    //manual set the dynamic parts for testing purposes
    bytes32 DOMAIN_SEPARATOR =
        keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256("App Name"),
                keccak256("1"),
                1,
                0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC
            )
        );

    struct MainStruct {
        uint256 _one;
        address _two;
        uint256 _three;
        address _four;
        TypeEnum typeEnum;
        uint256 _five;
        uint256 _six;
        uint256 _seven;
        uint256 _eight;
        SubStruct[] subStructs;
    }
    enum TypeEnum {
        TYPE_ONE,
        TYPE_TWO
    }

    struct SubStruct {
        address _foo;
        uint256 _bar;
    }

    function isValidHash(
        MainStruct memory mainStruct,
        bytes32 viemGeneratedHash
    ) public view returns (bool isValidHash, bytes32 hash) {
        isValidHash = (hashStruct(mainStruct) == viemGeneratedHash);
        hash = hashStruct(mainStruct);
    }

    function hashStruct(
        MainStruct memory params
    ) public view returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    DOMAIN_SEPARATOR,
                    keccak256(
                        abi.encode(
                            MAINSTRUCT_TYPEHASH,
                            params._one,
                            params._two,
                            params._three,
                            params._four,
                            params.typeEnum,
                            params._five,
                            params._six,
                            params._seven,
                            params._eight,
                            hashSubStructArray(params.subStructs)
                        )
                    )
                )
            );
    }

    function hashSubStructArray(
        SubStruct[] memory array
    ) internal view returns (bytes32 result) {
        bytes32[] memory _array = new bytes32[](array.length);
        for (uint256 i = 0; i < array.length; ++i) {
            _array[i] = keccak256(
                abi.encode(SUBSTRUCT_TYPEHASH, array[i]._foo, array[i]._bar)
            );
        }
        result = keccak256(abi.encodePacked(_array));
    }
}
