pragma solidity ^0.8.0;

import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/access/Ownable.sol";

error OnlyTxOrigin();
error StateAvailable();
error BasePrice();
error UndefinedCoordinates();

contract Dots {
    enum Types {
        Nulland,
        Argentina,
        Australia,
        Brazil,
        Canada,
        China,
        France,
        Germany,
        India,
        Indonesia,
        Italy,
        Japan,
        Korea,
        Mexico,
        Russia,
        SaudiArabia,
        SouthAfrica,
        Turkey,
        Ukraine,
        UnitedKingdom,
        UnitedStates
    }

    enum State {
        Available,
        Paused,
        Completed
    }

    struct Dot {
        address owner;
        Types country;
        uint256 last_price;
    }

    uint256 public constant x_width = 50;
    uint256 public constant y_width = 50;
    uint256 public constant EPSILON = 0.01 ether;
    uint256 public constant CLAIM_BASE_PRICE = 0.1 ether;

    State public state;

    mapping(uint256 => mapping(uint256 => Dot)) public lots;

    constructor() {
        state = State.Available;
    }

    function setState(State new_state) public {
        state = new_state;
    }

    function claimLocation(uint256 x, uint256 y) public payable {
        require(msg.sender == tx.origin, "Contracts can't bid");
        require(state == State.Available, "Game is paused or ended");
        require(msg.value >= CLAIM_BASE_PRICE, "lower-bound unsatisfied");
        require(msg.value >= lots[x][y].last_price + EPSILON, "delta_bid must be geq to epsilon");
        require(x <= x_width && y <= y_width, "undefined coordinates");
    }
}

contract Dots2 {
    enum Types {
        Nulland,
        Argentina,
        Australia,
        Brazil,
        Canada,
        China,
        France,
        Germany,
        India,
        Indonesia,
        Italy,
        Japan,
        Korea,
        Mexico,
        Russia,
        SaudiArabia,
        SouthAfrica,
        Turkey,
        Ukraine,
        UnitedKingdom,
        UnitedStates
    }

    enum State {
        Available,
        Paused,
        Completed
    }

    struct Dot {
        address owner;
        Types country;
        uint256 last_price;
    }

    uint256 public constant x_width = 50;
    uint256 public constant y_width = 50;
    uint256 public constant EPSILON = 0.01 ether;
    uint256 public constant CLAIM_BASE_PRICE = 0.1 ether;

    State public state;

    mapping(uint256 => mapping(uint256 => Dot)) public lots;

    constructor() {
        state = State.Available;
    }

    function claimLocation(uint256 x, uint256 y) public payable {
        if (msg.sender != tx.origin) {
            revert OnlyTxOrigin();
        }

        if (state != State.Available) {
            revert StateAvailable();
        }

        if (msg.value < CLAIM_BASE_PRICE) {
            revert BasePrice();
        }
        // TODO
        // implement Epsilon
        // convert this structure into if-revert-custom-error and write tests
        // require(msg.value >= lots[x][y].last_price + EPSILON, "delta_bid must be geq to epsilon");

        if (x > x_width || y > y_width) {
            revert UndefinedCoordinates();
        }
    }

    function setState(State new_state) public {
        state = new_state;
    }
}
