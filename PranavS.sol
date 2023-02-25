// contracts/PranavS.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./.deps/npm/@openzeppelin/contracts@4.8.1/token/ERC721/ERC721.sol";
import "./.deps/npm/@openzeppelin/contracts@4.8.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "./.deps/npm/@openzeppelin/contracts@4.8.1/access/Ownable.sol";
import "./.deps/npm/@openzeppelin/contracts@4.8.1/utils/Counters.sol";

contract PranavS is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    uint256 public mintRate = 0.01 ether;
    uint MAX_SUPPLY = 69420;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("PranavS", "PvS") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://pranavsalunkhe.vercel.app/tokens";
    }

    function safeMint(address to) public payable {
        require(totalSupply() < MAX_SUPPLY, "Can't mint more");
        require(msg.value >= mintRate, "Insufficient ether");
        _tokenIdCounter.increment(); 
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "The balance is 0");
        payable(owner()).transfer(address(this).balance);
    }

}

    