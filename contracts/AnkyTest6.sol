// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AnkyTest6 is ERC721 {
    // Define the variables
    uint256 public constant MAX_SUPPLY = 88;
    uint256 public constant PRICE = 0.0001 ether;
    uint256 private _lastMinted = 1;

    address immutable deployer;

    mapping (address => bool) private _hasMinted;

    constructor() ERC721("Anky", "ANKY") {
        deployer = msg.sender;
    }

    function mint() public payable {
        // Check if there is still supply available
        require(_lastMinted <  MAX_SUPPLY, "The Anky Genesis Collection is fully minted out");
        // Check the amount of eth sent
        require(PRICE <= msg.value, "Eth value sent is incorrect");
        // Check if the address has minted
        require(!_hasMinted[msg.sender], "This address already minted an Anky");
        // Check if the address already owns an Anky
        require(balanceOf(msg.sender) == 0, "This address already contains an Anky");
        // Mint the anky that comes now
        _mint(msg.sender, _lastMinted);
        // Mark this address as one that already minted an anky
        _hasMinted[msg.sender] = true;
        // Prepare for the next mint
        _lastMinted++;
    }

    // Set the ipfs uri to point to the metadata
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmXwnt94PkQTWzcmdhguBHp3UvyAGyq8wV2fCBJB3y6PKL/";
    }


    function withdraw() public {
        require(msg.sender == deployer, "Only the deployer can request withdraw");
        uint256 balance = address(this).balance;
        payable(deployer).transfer(balance);
    }
}
