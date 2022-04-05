pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SubscriptionPlan {

  //uint public nextPlanId;

  struct Plan {
    address merchant;
    string planName;
    address token;
    uint amount;
    uint frequency;
  }
  
  struct Subscription {
    address subscriber;
    uint start;
    uint nextPayment;
  }

  //mapping(uint => Plan) public plans;

  mapping(address => Subscription) public subscriptions;

  event PlanCreated(
    address merchant,
    uint date
  );
  
  event SubscriptionCreated(
    address subscriber,
    uint date
  );

  event SubscriptionCancelled(
    address subscriber,
    uint date
  );

  event PaymentSent(
    address from,
    address to,
    uint amount,
    uint date
  );

  Plan public newPlan;

  constructor(address token, string memory name, uint amount, uint frequency) {
    newPlan = Plan(
      msg.sender, 
      name,
      token,
      amount, 
      frequency
    );
    //nextPlanId++;
  }

  // function createPlan(address token, string memory name, uint amount, uint frequency) external {
  //   require(token != address(0), "address cannot be null address");
  //   require(amount > 0, "amount needs to be > 0");
  //   require(frequency > 0, "frequency needs to be > 0");
  //   plans[nextPlanId] = Plan(
  //     msg.sender, 
  //     name,
  //     token,
  //     amount, 
  //     frequency
  //   );
  //   nextPlanId++;
  // }

  function subscribe() external {
    IERC20 token = IERC20(newPlan.token);
    require(newPlan.merchant != address(0), "this plan does not exist");

    token.transferFrom(msg.sender, newPlan.merchant, newPlan.amount);  
    emit PaymentSent(
      msg.sender, 
      newPlan.merchant, 
      newPlan.amount,
      block.timestamp
    );

    subscriptions[msg.sender] = Subscription(
      msg.sender, 
      block.timestamp, 
      block.timestamp + newPlan.frequency
    );
    emit SubscriptionCreated(msg.sender, block.timestamp);
  }

  function cancel() external {
    Subscription storage subscription = subscriptions[msg.sender];
    require(
      subscription.subscriber != address(0), 
      "this subscription does not exist"
    );
    delete subscriptions[msg.sender]; 
    emit SubscriptionCancelled(msg.sender, block.timestamp);
  }

  function renew(address subscriber) external {
    Subscription storage subscription = subscriptions[subscriber];
    IERC20 token = IERC20(newPlan.token);
    require(
      subscription.subscriber != address(0), 
      "this subscription does not exist"
    );
    require(
      block.timestamp > subscription.nextPayment,
      "not due yet"
    );

    token.transferFrom(subscriber, newPlan.merchant, newPlan.amount);  
    emit PaymentSent(
      subscriber,
      newPlan.merchant, 
      newPlan.amount,
      block.timestamp
    );
    subscription.nextPayment = subscription.nextPayment + newPlan.frequency;
  }
}