// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Dots.sol";
import "../src/IDots.sol";

contract DotTest is Test, IDots {
    Dots public dot;
    Dots2 public dot2;
    address alice = makeAddr("alice");

    function setUp() public {
        dot = new Dots();
        dot2 = new Dots2();
    }

    function testOnlyTxOriginCanCall() public {
        vm.prank(alice, alice);
        dot.claimLocation();
    }

    function testContractCallFail() public {
        vm.expectRevert(bytes("Contracts can't bid"));
        dot.claimLocation();
    }

    function testOnlyTxOriginCanCall_OptimizedFail() public {
        vm.expectRevert(OnlyTxOrigin.selector);
        dot2.claimLocation();
    }

    function testOnlyTxOriginCanCall_Optimized() public {
        vm.prank(alice, alice);
        dot2.claimLocation();
    }

    function testStateAvailable() public {
        assertEq(uint256(dot2.state()), 0);
        dot2.setState(uint8(1));
    }
}
