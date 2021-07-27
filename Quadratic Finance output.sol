pragma solidity ^0.8.4;

contract QuadraticFinance {
    mapping (address => bool) donor;
    uint256 public sqrt_total;
    
    receive() external payable {
        require(donor[msg.sender] == false,
            "You have already donated");
        uint256 sqrt_amount=sqrt_uniswap(msg.value);
        sqrt_total=sqrt_total+sqrt_amount;
        donor[msg.sender]=true;
    }
    
    fallback() external payable {}
    
    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    // calculating square roots using method from uniswap
    
     function sqrt_uniswap(uint y) public pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
    
    // output the quadratic funding total amount. For a detailed intro, see https://vitalik.ca/general/2019/12/07/quadratic.html
    function total_contribution() public view returns (uint256) {
        return (sqrt_total) ** 2;
    }
}
