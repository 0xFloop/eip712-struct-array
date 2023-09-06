import { TypedDataDomain, getAddress, hashTypedData } from "viem";

const domain = {
  name: "App Name",
  version: "1",
  chainId: 1,
  verifyingContract: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",
} as TypedDataDomain;

const types = {
  SubStruct: [
    { name: "_foo", type: "address" },
    { name: "_bar", type: "uint256" },
  ],
  MainStruct: [
    { name: "_one", type: "uint256" },
    { name: "_two", type: "address" },
    { name: "_three", type: "uint256" },
    { name: "_four", type: "address" },
    { name: "typeEnum", type: "uint8" },
    { name: "_five", type: "uint256" },
    { name: "_six", type: "uint256" },
    { name: "_seven", type: "uint256" },
    { name: "_eight", type: "uint256" },
    { name: "subStructs", type: "SubStruct[]" },
  ],
};

const TypeEnum = {
  TYPE_ONE: 0,
  TYPE_TWO: 1,
};

type SubStruct = {
  _foo: string;
  _bar: number;
};

const subStructs: SubStruct[] = [
  { _foo: "0x0000000000000000000000000000000000000001", _bar: 1 },
  { _foo: "0x0000000000000000000000000000000000000002", _bar: 2 },
];

async function main() {
  let message = {
    _one: 1,
    _two: "0x0000000000000000000000000000000000000002",
    _three: 3,
    _four: "0x0000000000000000000000000000000000000004",
    typeEnum: TypeEnum.TYPE_ONE,
    _five: 5,
    _six: 6,
    _seven: 7,
    _eight: 8,
    subStructs: subStructs,
  };

  const hash = hashTypedData({
    domain,
    primaryType: "MainStruct",
    types,
    message,
  });

  console.log("hash: ", hash);
}
main();
