pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract GasTest is Test {
    Contract1 public c1;
    Contract2 public c2;

    function setUp() public {
        c1 = new Contract1();
        c2 = new Contract2(50, 50);
    }

    function testConstants_C1() public {
        assertEq(c1.x_width(), 50);
        assertEq(c1.y_width(), 50);
    }

    function testConstants_C2() public {
        assertEq(c2.x_width(), 50);
        assertEq(c2.y_width(), 50);
    }
}

contract Contract1 {
    uint256 public constant x_width = 50;
    uint256 public constant y_width = 50;
}

contract Contract2 {
    uint256 public immutable x_width;
    uint256 public immutable y_width;

    constructor(uint256 x_width_, uint256 y_width_) {
        x_width = x_width_;
        y_width = y_width_;
    }
}
