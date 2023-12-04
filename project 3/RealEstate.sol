// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ImportedSolLibraries/SafeMath.sol";

contract RealEstate {
    using Math for uint256;

    struct Property {
        uint256 price;
        address owner;
        bool forSale;
        string name;
        string description;
        string location;
    }

    mapping(uint256 => Property) public properties;

    uint256[] public propertyIds;

    event PropertySold(
        uint256 propertyId,
        address previousOwner,
        address newOwner
    );

    function listPropertyForSale(
        uint256 _propertyId,
        uint256 _price,
        string memory _name,
        string memory _description,
        string memory _location
    ) public {
        Property memory newProperty = Property({
            price: _price,
            owner: msg.sender,
            forSale: true,
            name: _name,
            description: _description,
            location: _location
        });

        properties[_propertyId] = newProperty;
        propertyIds.push(_propertyId);
    }

    function buyProperty(uint256 _propertyId) public payable {
        Property storage property = properties[_propertyId];

        require(property.forSale, "Property is not for sale");
        require(property.price <= msg.value, "Insufficient funds");

        payable(property.owner).transfer(msg.value);

        emit PropertySold(_propertyId, property.owner, msg.sender);

        property.owner = msg.sender;
        property.forSale = false;
    }
}
