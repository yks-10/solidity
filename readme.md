# SOLIDITY:
    Solidity is a contract oriented, high level language used for implementing the smart contract.
    It was influenced by C++, python , javascript and is designed to target the Ethereum Virtual Machine.
 [SOLIDITY_LEARNLINK](https://www.dappuniversity.com/articles/solidity-tutorial "TUTORIAL")

    
**PROGRAM:**
    
    pragma solidity ^0.4.24;
    contract Mycontract{
        string value;
        constructor() public{
            value = "myValue";
        }
        function get() public view returns(string){
            return value;
        }   
        function set(string _value)public{
            value = _value;
        }
    }
    

    pragma solidity 0.5.1;
    contract Mycontract{
        string public value = "myValue";
        function set(string memory _value) public {
            value = _value;
        }
    }

**DATA TYPES:**

    pragma solidity 0.5.1;
    contract Mycontract{
        string public constant stringValue = "myString";
        bool public myBool =  true;
        int public myInt = -1;
        uint public myUnit = 1;
        uint8 public myUint8 = 8;
        uint256 public myUint256 = 9999;
    }

**ENUM :**

    pragma solidity 0.5.1;
    contract Mycontract{
    enum State { Waiting, Ready, Active}
        State public state;

        constructor() public{
            state = State.Waiting;
        }
        function activate() public{
            state = State.Active;
        }
        function isActivate() public view returns(bool){
            return state == State.Active;
        }
    }

**STRUCT:**
    
    pragma solidity 0.5.1;
    contract Mycontract{
        Person[] public people;
    
        uint256 public peopleCount;
    
        struct Person{
            string _firstName;
            string _lastName;
        }
    
        function addPerson( string memory _firstName, string memory _lastName) public{
            peopleCount +=1;
            people.push(Person(_firstName,_lastName));
        }
    }

**MAPPING:**
    
    pragma solidity 0.5.1;
    contract Mycontract{
        uint256 public peopleCount = 0;
        mapping(uint => Person) public people;
    
        struct Person{
            uint _id;
            string _firstName;
            string _lastName;
        }
    
        function addPerson( string memory _firstName, string memory _lastName) public{
            peopleCount +=1;
            people[peopleCount] = Person(peopleCount, _firstName, _lastName);
        }
    }


**FUNCTION:**

    pragma solidity 0.5.1;
    contract Mycontract{
        uint256 public peopleCount = 0;
        mapping(uint => Person) public people;
    
        struct Person{
            uint _id;
            string _firstName;
            string _lastName;
        }
    
        function addPerson( string memory _firstName, string memory _lastName) public{
            incrementCount();
            people[peopleCount] = Person(peopleCount, _firstName, _lastName);
        }
    
        function incrementCount() internal{
            peopleCount +=1;
        }
    }


**MODIFIERS:**

    pragma solidity 0.5.1;
    contract Mycontract{
        uint256 public peopleCount = 0;
        mapping(uint => Person) public people;
        address owner;
    
        modifier onlyOwner(){
            require(msg.sender == owner);
            _;
        }
    
        struct Person{
            uint _id;
            string _firstName;
            string _lastName;
        }
    
        constructor() public{
            owner = msg.sender;
        }
    
        function addPerson( 
            string memory _firstName, 
            string memory _lastName
        )
        public onlyOwner 
        {
            incrementCount();
            people[peopleCount] = Person(peopleCount, _firstName, _lastName);
        }
    
        function incrementCount() internal{
            peopleCount +=1;
        }
    }


**TIME :**
1. [Epochtime](https://www.epochconverter.com/)
2. block.timestamp 
3. require


    pragma solidity 0.5.1;
    contract Mycontract{
        uint256 public peopleCount = 0;
        mapping(uint => Person) public people;
        address owner;
        uint256 openingTime = 1651037112;
        modifier onlyWhileOpen(){
            require(block.timestamp >= openingTime);
            _;
        }
    
        struct Person{
            uint _id;
            string _firstName;
            string _lastName;
        }
    
        constructor() public{
            owner = msg.sender;
        }
    
        function addPerson( 
            string memory _firstName, 
            string memory _lastName
        )
        public onlyWhileOpen 
        {
            incrementCount();
            people[peopleCount] = Person(peopleCount, _firstName, _lastName);
        }
    
        function incrementCount() internal{
            peopleCount +=1;
        }
    }

## SMART CONTRACT

   1. solidity compiler 
   2. copy the account to deploy 
   3. To check balance enter the account address 
   4. To enter the new ether 
      1. select as ether 
      2. enter the value 
      3. then buyToken 


   **PROGRAM :**
    
        pragma solidity 0.5.1;
        contract Mycontract{
            mapping(address => uint256) public balances;
            address payable wallet;
        
            constructor(address payable _wallet) public{
                wallet = _wallet;
            }
        
            function buyToken() public payable{
                //buy a token
                balances[msg.sender] +=1; 
                //sending a ether to wallet
                wallet.transfer(msg.value);
            }
        }
