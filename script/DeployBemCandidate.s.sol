// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "lib/forge-std/src/Script.sol";
import "contracts/BemCandidate.sol";

contract DeployBemCandidate is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        BemCandidate bem = new BemCandidate();

        console.log("BemCandidate deployed to:");
        console.log(address(bem));

        vm.stopBroadcast();
    }
}
