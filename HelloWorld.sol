// SPDX-License-Identifier: MIT

//specifies which version the codesis for
pragma solidity 0.8.7;

//contract creation
contract HelloWorld {

    //declaration of stateVariable named number of unsigned integer type
    uint number;

    //creation of a storeNumber function to store the uint
    function storeNumber(uint x) public {
        number=x;
    }

    //retrieveNumber function to retrieve it
    function retrieveNumber() public view returns (uint) {
        return number;
    }
}