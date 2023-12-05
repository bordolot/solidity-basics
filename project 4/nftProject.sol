// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ImportedSolLibraries/contracts/token/ERC721/ERC721.sol";
import "./ImportedSolLibraries/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./ImportedSolLibraries/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "./ImportedSolLibraries/contracts/access/Ownable.sol";

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract Web3Builders is ERC721, ERC721Enumerable, ERC721Pausable, Ownable {
    uint256 private _nextTokenId;
    uint256 maxSuply = 1;

    bool public publicMintOpen = false;
    bool public allowListMintOpen = false;

    mapping(address => bool) public allowList;

    constructor(
        address initialOwner
    ) ERC721("Web3Builders", "WE3") Ownable(initialOwner) {}

    function _baseURI() internal pure override returns (string memory) {
        // return "ipfs://QmY5rPqGTN1rZxMQg2ApiSZc7JiBNs1ryDzXPZpQhC1ibm/";
        return "https://myexampletokenstoresite.com/supertoken/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function editMintWindows(
        bool _publicMintOpen,
        bool _allowLintMintOpen
    ) external onlyOwner {
        publicMintOpen = _publicMintOpen;
        allowListMintOpen = _allowLintMintOpen;
    }

    // require onle allow list of people
    // Add publicMint and allowListMintOpen variables
    function allowListMint() public payable {
        require(allowListMintOpen, "AllowList Mint Closed");
        require(allowList[msg.sender] == true, "You are not on the allow list");
        require(msg.value == 0.001 ether, "Not enought ether");
        internalMint();
    }

    // function safeMint(address to) public onlyOwner {
    //     uint256 tokenId = _nextTokenId++;
    //     _safeMint(to, tokenId);
    // }

    //Add payment
    //Add limiting of suply
    function publicMint() public payable {
        require(publicMintOpen, "Public Mint Closed");
        require(msg.value == 0.01 ether, "Not enought ether");
        internalMint();
    }

    function internalMint() internal {
        require(totalSupply() < maxSuply, "No more suply");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
    }

    function withdraw(address _addr) external onlyOwner {
        //get balance
        uint256 balance = address(this).balance;
        payable(_addr).transfer(balance);
    }

    // populate the allow list
    function sellAllowList(address[] calldata addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            allowList[addresses[i]] = true;
        }
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    )
        internal
        override(ERC721, ERC721Enumerable, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
