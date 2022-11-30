pragma solidity ^0.8.0;

import "openzeppelin-contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/access/Ownable.sol";

error OnlyTxOrigin();
error StateAvailable();

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

    State public state;

    constructor() {
        state = State.Available;
    }

    function claimLocation() public view {
        require(msg.sender == tx.origin, "Contracts can't bid");
        require(state == State.Available, "Game is paused or ended");
    }
}

contract Dots2  {
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

    State public state;

    constructor() {
        state = State.Available;
    }

    function claimLocation() public view {
        if (msg.sender != tx.origin) {
            revert OnlyTxOrigin();
        }

        if (state != State.Available) {
            revert StateAvailable();
        }
    }

    function setState(State new_state) public {
        state = new_state;
    }
}
