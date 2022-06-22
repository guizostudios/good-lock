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
        string memory _name,
        string memory _image,
        string memory _description, 
        string memory _location, 
        uint _price
    ) public {
        uint _sold = 0;
        contracts[contractsLength] = Contract(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _location,
            _price,
            _sold
        );
        contractsLength++;
    }

    function readContract(uint _index) public view returns (
        address payable,
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint, 
        uint
    ) {
        return (
            contracts[_index].owner,
            contracts[_index].name, 
            contracts[_index].image, 
            contracts[_index].description, 
            contracts[_index].location, 
            contracts[_index].price,
            contracts[_index].sold
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
}