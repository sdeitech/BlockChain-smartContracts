// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    // Variable to keep track of the next token ID
    uint256 private _nextTokenId;

    // Base URI for metadata
    string private _baseTokenURI;

    constructor(string memory baseURI) ERC721("MyNFT", "MNFT") {
        _baseTokenURI = baseURI;
    }

    // Function to mint a new NFT
    function mintNFT(address recipient) external onlyOwner {
        uint256 newTokenId = _nextTokenId;
        _safeMint(recipient, newTokenId);
        _nextTokenId++;
    }

    // Override baseURI
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    // Function to transfer NFT
    function transferNFT(address from, address to, uint256 tokenId) external {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Caller is not owner nor approved");
        _transfer(from, to, tokenId);
    }

    // Function to update the base URI
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    // Get the next token ID (for external view)
    function nextTokenId() external view returns (uint256) {
        return _nextTokenId;
    }
}
