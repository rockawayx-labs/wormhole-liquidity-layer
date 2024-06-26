// SPDX-License-Identifier: Apache 2

pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IWormhole} from "wormhole-solidity-sdk/interfaces/IWormhole.sol";
import {ITokenMessenger} from "src/interfaces/external/ITokenMessenger.sol";
import "./ITokenRouterTypes.sol";

interface ITokenRouterState {
    /**
     * @notice Returns the chain ID of the matching engine.
     */
    function matchingEngineChain() external view returns (uint16);

    /**
     * @notice Returns the address of the matching engine.
     */
    function matchingEngineAddress() external view returns (bytes32);

    /**
     * @notice Returns the mint recipient of the matching engine.
     */
    function matchingEngineMintRecipient() external view returns (bytes32);

    /**
     * @notice Returns the domain of the matching engine.
     */
    function matchingEngineDomain() external view returns (uint32);

    /**
     * @notice Returns the router address for a given chain ID.
     * @param chain The Wormhole chain ID.
     */
    function getRouter(uint16 chain) external view returns (bytes32);

    /**
     * @notice Returns the mint recipient for a given chain ID.
     * @param chain The Wormhole chain ID.
     */
    function getMintRecipient(uint16 chain) external view returns (bytes32);

    /**
     * @notice Returns the router endpoint for a given chain ID.
     * @param chain The Wormhole chain ID.
     */
    function getRouterEndpoint(uint16 chain) external view returns (Endpoint memory);

    /**
     * @notice Returns the Circle domain for a given chain ID.
     * @param chain The Wormhole chain ID.
     */
    function getDomain(uint16 chain) external view returns (uint32);

    /**
     * @notice Returns allow listed token address for this router.
     */
    function orderToken() external view returns (IERC20);

    /**
     * @notice Returns the Wormhole contract interface.
     */
    function wormhole() external view returns (IWormhole);

    /**
     * @notice Returns the Wormhole chain ID.
     */
    function wormholeChainId() external view returns (uint16);

    /**
     * @notice Returns the original `deployer` of the contracts.
     * @dev This is not the `owner` of the contracts.
     */
    function getDeployer() external view returns (address);

    /**
     * @notice Returns a boolean which indicates if outbound fast transfers are enabled.
     * @dev The `owner` of the contract can disable fast transfers by setting the
     * `feeInBps` to zero.
     */
    function fastTransfersEnabled() external view returns (bool);

    /**
     * @notice Returns the current `FastTransferParameters` struct from storage. See
     * `ITokenRouterTypes.sol` for the struct definition.
     */
    function getFastTransferParameters() external view returns (FastTransferParameters memory);

    /**
     * @notice Returns the minimum fast transfer amount for fast transfers.
     */
    function getMinFastTransferAmount() external view returns (uint64);

    /**
     * @notice Returns the minimum fee for fast transfers. This includes the `baseFee`
     * and `initialAuctionFee`.
     */
    function getMinFee() external pure returns (uint64);

    /**
     * @notice Returns the maximum fast transfer amount for fast transfers.
     */
    function getMaxFastTransferAmount() external view returns (uint64);

    /**
     * @notice Returns the initial auction fee for fast transfers. This is the fee
     * the relayer is paid for starting a fast transfer auction.
     */
    function getInitialAuctionFee() external view returns (uint64);

    /**
     * @notice Returns the base fee for fast transfers. This is the fee the relayer
     * is paid for relaying the CCTP message associated with a fast transfer. This fee
     * is only paid in the a fast transfer auction does not occur.
     */
    function getBaseFee() external view returns (uint64);

    /**
     * @notice Returns the maximum payload size for the redeemer message.
     */
    function getMaxPayloadSize() external pure returns (uint256);
}
