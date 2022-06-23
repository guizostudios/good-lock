// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
  function transfer(address, uint256) external returns (bool);
  function approve(address, uint256) external returns (bool);
  function transferFrom(address, address, uint256) external returns (bool);
  function totalSupply() external view returns (uint256);
  function balanceOf(address) external view returns (uint256);
  function allowance(address, address) external view returns (uint256);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ContractPool {

    uint internal contractsLength = 0;
    address internal cUsdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;
    address internal cEURTokenAddress = 0x10c892A6EC43a53E45D0B916B4b7D383B1b78C0F;
    address internal cRealTokenAddress = 0xE4D517785D091D3c54818832dB6094bcc2744545;

    struct Contract {
        address payable owner;
        address payable taker;
        string contractname;
        string token;
        uint balanceowner;
        uint balancetaker;
        uint preagreementowner;
        uint preagreementtaker;
        uint agreementtaker;
        uint daystowithdraw;
        uint daystodeposit;
        uint256 enddate;
    }

    mapping (uint => Contract) internal contracts;

    function writeContract(
        string memory _contractname,
        string memory _token,
        uint _preagreementowner,
        uint _preagreementtaker,
        uint _agreementtaker,
        uint _daystowithdraw,
        uint _daystodeposit,
        uint256 _enddate

    ) public {
        uint _balanceowner = 0,
        uint _balancetaker = 0;
        contracts[contractsLength] = Contract(
            payable(msg.owner),
            payable(msg.taker),
        _contractname,
        _token,
        _preagreementowner,
        _preagreementtaker,
        _agreementtaker,
        _daystowithdraw,
        _daystodeposit,
        _enddate,
        _balanceowner,
        _balancetaker

        );
        contractsLength++;
    }

    function readContract(uint _index) public view returns (
        address payable,
        address payable,
        string memory,
        string memory,
        uint,
        uint,
        uint,
        uint,
        uint,
        uint,
        uint,
        uint256
    ) {
        return (
            contracts[_index].owner,
            contracts[_index].taker, 
            contracts[_index].contractname, 
            contracts[_index].token, 
            contracts[_index].balanceowner, 
            contracts[_index].balancetaker,
            contracts[_index].preagreementowner,
            contracts[_index].preagreementtaker, 
            contracts[_index].agreementtaker, 
            contracts[_index].daystowithdraw,
            contracts[_index].daystodeposit,
            contracts[_index].enddate
        );
    }

    function buyContract(uint _index) public payable  {
        require(
          IERC20Token(cUsdTokenAddress).transferFrom(
            msg.sender,
            contracts[_index].owner,
            contracts[_index].price
          ),
          "Transfer failed."
        );
        contracts[_index].sold++;
    }
    
    function getContractsLength() public view returns (uint) {
        return (contractsLength);
    }

    function addContract

    function withdrawContract

    function burnContract

    function changeContract

    function execContract
}