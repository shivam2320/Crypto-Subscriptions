pragma solidity ^0.8.0;

import "./cryptoSubscription.sol";

contract subscriptionFactory {

    address[] contracts;

    event PlanCreated(address indexed planAddress);

    function deploySubscriptionPlan(address token, string memory name, uint amount, uint frequency) public returns (address) {
        require(token != address(0), "address cannot be null address");
        require(amount > 0, "amount needs to be > 0");
        require(frequency > 0, "frequency needs to be > 0");
        SubscriptionPlan N = new SubscriptionPlan(token, name, amount, frequency);

        emit PlanCreated(address(N));
        return address(N);
    }

    function getContracts() public view returns(address[] memory) {
        return contracts;
    }

}