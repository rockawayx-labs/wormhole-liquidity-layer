// SPDX-License-Identifier: Apache 2

pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import {TokenRouter} from "src/TokenRouter/TokenRouter.sol";

import {CheckWormholeContracts} from "./helpers/CheckWormholeContracts.sol";

import {Utils} from "src/shared/Utils.sol";

contract DeployTokenRouterContracts is CheckWormholeContracts, Script {
    using Utils for address;

    uint16 immutable _chainId = uint16(vm.envUint("RELEASE_CHAIN_ID"));

    address immutable _token = vm.envAddress("RELEASE_TOKEN_ADDRESS");
    address immutable _wormhole = vm.envAddress("RELEASE_WORMHOLE_ADDRESS");
    address immutable _cctpTokenMessenger = vm.envAddress("RELEASE_TOKEN_MESSENGER_ADDRESS");
    address immutable _ownerAssistantAddress = vm.envAddress("RELEASE_OWNER_ASSISTANT_ADDRESS");
    bytes32 immutable _matchingEngineAddress = vm.envBytes32("RELEASE_MATCHING_ENGINE_ADDRESS");
    bytes32 immutable _matchingEngineMintRecipient =
        vm.envBytes32("RELEASE_MATCHING_ENGINE_MINT_RECIPIENT");
    uint16 immutable _matchingEngineChain = uint16(vm.envUint("RELEASE_MATCHING_ENGINE_CHAIN"));
    uint32 immutable _matchingEngineDomain = uint32(vm.envUint("RELEASE_MATCHING_ENGINE_DOMAIN"));

    function deployAndConfigure() public {
        requireValidChain(_chainId, _wormhole);

        TokenRouter implementation = new TokenRouter(
            _token,
            _wormhole,
            _cctpTokenMessenger,
            _matchingEngineChain,
            _matchingEngineAddress,
            _matchingEngineMintRecipient,
            _matchingEngineDomain
        );

        TokenRouter proxy =
            TokenRouter(address(new ERC1967Proxy(address(implementation), "")));

        proxy.initialize(abi.encodePacked(_ownerAssistantAddress));

        console2.log("Deployed TokenRouter (chain=%s): %s", _chainId, address(proxy));
    }

    function run() public {
        // Begin sending transactions.
        vm.startBroadcast();

        // Deploy proxy and initialize.
        deployAndConfigure();

        // Done.
        vm.stopBroadcast();
    }
}
