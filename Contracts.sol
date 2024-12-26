
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TreePlantingInitiative {
    // Struct to represent a planted tree
    struct Tree {
        address planter;
        uint256 plantedDate;
        uint256 carbonCredits;
        bool verified;
        string location;
    }

    // Mapping to store trees
    mapping(uint256 => Tree) public trees;
    
    // Counter for tree IDs
    uint256 public treeCounter;

    // Events to log important actions
    event TreePlanted(
        uint256 treeId, 
        address planter, 
        string location, 
        uint256 plantedDate
    );
    
    event CarbonCreditsClaimed(
        uint256 treeId, 
        address planter, 
        uint256 carbonCredits
    );

    /**
     * @dev Allows users to plant a tree and record its details
     * @param _location Geographic location of the planted tree
     * @return treeId Unique identifier for the newly planted tree
     */
    function plantTree(string memory _location) public returns (uint256) {
        // Increment tree counter to create unique ID
        treeCounter++;

        // Calculate initial carbon credits (simplified example)
        // In a real-world scenario, this would involve more complex calculations
        uint256 initialCarbonCredits = 10; 

        // Create new tree record
        trees[treeCounter] = Tree({
            planter: msg.sender,
            plantedDate: block.timestamp,
            carbonCredits: initialCarbonCredits,
            verified: false,
            location: _location
        });

        // Emit event for tree planting
        emit TreePlanted(treeCounter, msg.sender, _location, block.timestamp);

        return treeCounter;
    }

    /**
     * @dev Allows verified planters to claim carbon credits for their planted trees
     * @param _treeId Unique identifier of the tree
     * @return claimedCredits Number of carbon credits claimed
     */
    function claimCarbonCredits(uint256 _treeId) public returns (uint256) {
        // Retrieve the tree
        Tree storage tree = trees[_treeId];

        // Verify that the caller is the original planter
        require(tree.planter == msg.sender, "Only the original planter can claim credits");

        // Ensure the tree exists
        require(_treeId > 0 && _treeId <= treeCounter, "Invalid tree ID");

        // In a real-world scenario, you would add additional verification steps
        // For this example, we'll simulate verification
        tree.verified = true;

        // Claim carbon credits
        uint256 claimedCredits = tree.carbonCredits;

        // Emit event for carbon credits claim
        emit CarbonCreditsClaimed(_treeId, msg.sender, claimedCredits);

        // Reset carbon credits to prevent double-claiming
        tree.carbonCredits = 0;

        return claimedCredits;
    }
}
