pragma solidity ^0.4.24;

import "stringUtils.sol";


contract Transaction {

    /* STRUCTURES */
    // General
    struct Denomination {
        string VALUE;
        string COUNT;
    }

    struct Timestamp {
        string TIMESTAMP;
        string DATE;
        string TIME;
    }

    struct Location {
        string LATITUDE;
        string LONGITUDE;
        string DISTRICT;
        string STATE;
    }

    // User
    struct User {
        string USERNAME;
        string PASSWORD;
        string NAME;
        string ID;
        string ACCOUNT;
        string ENTITY;
    }

    // Entity
    struct CurrencyChest {
        string BALANCE;
        string TRIGGER;
        mapping(string => Denomination) CURRENCYCHEST;
    }

    struct Entity {
        string ID;
        string NAME;
        string PARENT;
        string BANK;
        string TYPE;
        Location LOCATION;
        CurrencyChest CURRENCYCHEST;
    }

    // Transaction
    struct Approver {
        string USERNAME;
        string STATUS;
        string MANDATORY;
    }

    struct Bundle {
        string ID;
        string BALANCE;
        mapping(string => Denomination) CURRENCYCHEST;
    }


    struct Transaction{
        string ID;
        string CHAIN;

        string[] SENDERS;
        string[] RECEIVERS;

        string[] REQUESTORS;
        Approver[] APPROVERS;

        Bundle PAYLOAD;

        Location LOCATION;
        Timestamp TIMESTAMP;

        string TYPE;
        string DESCRIPTION;
    }


    /* Mappings */
    mapping(string => User) userList;
    mapping(string => Entity) entityList;
    mapping(string => Transaction) transactionList;
    Denomination[] DENOMINATIONS = ["1", "5", "10", "20", "50", "100", "200", "500", "2000"];

    mapping(string => string[]) entityTransactionList;
    mapping(string => string[]) bankTransactionList;

    mapping(string => string[]) userTransactionList;

    mapping(string => string[]) denominationTransactionList;
    
    mapping(string => string[]) timestampTransactionList;
    mapping(string => string[]) dateTransactionList;
    mapping(string => string[]) timeTransactionList;
    
    mapping(string => string[]) districtTransactionList;
    mapping(string => string[]) stateTransactionList;

    mapping(string => string[]) bundleTransactionList;
    mapping(string => string[]) bundleEntityList;


    /* UTILITY OBJECTS */
    // Transaction Objects
    Transaction[] transactionList;

    // User Objects
    User user_obj;
    
    // Entity Objects
    Entity entity_obj;
    Location location_obj;
    CurrencyChest currencychest_obj;

    //Utility Objects
    Location location_obj;
    Timestamp timestamp_obj;
    Bundle bundle_obj;
    Denomination denomination_obj;


    /* SETTERS AND GETTERS */
    // User Functions
    function setUser(          
        string USERNAME,
        string PASSWORD,
        string NAME,
        string ID,
        string ACCOUNT,
        string ENTITY,
    ) public {
        user_obj = User({
            USERNAME:USERNAME,
            PASSWORD:PASSWORD,
            NAME:NAME,
            ID:ID,
            ACCOUNT:ACCOUNT,
            ENTITY:ENTITY
        });
        userList[USERNAME] = user_obj;
    }

    function getUser(
        string USERNAME
    ) public {
        user_obj = userList[USERNAME];
        return (
            user_obj.USERNAME,
            user_obj.PASSWORD,
            user_obj.NAME,
            user_obj.ID,
            user_obj.ACCOUNT,
            user_obj.ENTITY
        );
    }

    function setUserPassword (
        string USERNAME,
        string PASSWORD
    ) {
        userList[USERNAME].PASSWORD = PASSWORD;
    }

    function getUserPassword (
        string USERNAME,
    ) public {
        return userList[USERNAME].PASSWORD;
    }

    function setUserName (
        string USERNAME,
        string NAME
    ) {
        userList[USERNAME].NAME = NAME;
    }
    function getUserName (
        string USERNAME,
    ) public {
        return userList[USERNAME].NAME;
    }

    function setUserId (
        string USERNAME,
        string ID
    ) {
        userList[USERNAME].ID = ID;
    }
    function getUserId (
        string USERNAME,
    ) public {
        return userList[USERNAME].ID;
    }

    function setUserAccount (
        string USERNAME,
        string ACCOUNT
    ) {
        userList[USERNAME].ACCOUNT = ACCOUNT;
    }
    function getUserAccount (
        string USERNAME,
    ) public {
        return userList[USERNAME].ACCOUNT;
    }

    function setUserEntity (
        string USERNAME,
        string ENTITY
    ) {
        userList[USERNAME].ENTITY = ENTITY;
    }
    function getUserEntity (
        string USERNAME,
    ) public {
        return userList[USERNAME].ENTITY;
    }

    // Entity Functions
    function setUserEntity (
        string USERNAME,
        string ENTITY
    ) {
        userList[USERNAME].ENTITY = ENTITY;
    }
    function getUserEntity (
        string USERNAME,
    ) public {
        return userList[USERNAME].ENTITY;
    }


    function setEntity(
        string ID,
        string NAME,
        string PARENT,
        string BANK,
        string TYPE,
        string LATITUDE,
        string LONGITUDE,
        string DISTRICT,
        string STATE
        string BALANCE,
        string TRIGGER,
    ) public {
        location_obj = Location({
            LATITUDE:LATITUDE,
            LONGITUDE:LONGITUDE,
            DISTRICT:DISTRICT,
            STATE:STATE
        });

        currencychest_obj = CurrencyChest({
            BALANCE:BALANCE,
            TRIGGER:TRIGGER
        });

         
        for(uint i=0;i<DENOMINATIONS.length;i++){
            denomination_obj = Denomination({
                VALUE:DENOMINATIONS[i],
                COUNT:0
            });
            currencychest_obj.CURRENCYCHEST[DENOMINATIONS[i]] = denomination_obj;
        }

        entity_obj = Entity({
            ID:ID,
            NAME:NAME,
            PARENT:PARENT,
            BANK:BANK,
            TYPE:TYPE,
            LOCATION:location_obj,
            CURRENCYCHEST:currencychest_obj
        });

        entityList[ID]=entity_obj;
    }
    function getEntity (
        string ID
    ) public {
        entity_obj = entityList[ID];
        return (
            entityList[ID].ID,
            entityList[ID].NAME,
            entityList[ID].PARENT,
            entityList[ID].BANK,
            entityList[ID].TYPE,
            entityList[ID].LOCATION.LATITUDE,
            entityList[ID].LOCATION.LONGITUDE,
            entityList[ID].LOCATION.DISTRICT,
            entityList[ID].CURRENCYCHEST.BALANCE,
            entityList[ID].CURRENCYCHEST.TRIGGER
        );
    }

    function setEntityCurrencyChestDenomination (
        string ID,
        string VALUE,
        string COUNT
    ) public {
        entityList[ID].CURRENCYCHEST[VALUE].VALUE:VALUE,
        entityList[ID].CURRENCYCHEST[VALUE].COUNT:COUNT
    }
    function getEntityCurrencyChestDenomination (
        string ID,
        string VALUE
    ) public {
        return (
            entityList[ID].CURRENCYCHEST[VALUE].VALUE,
            entityList[ID].CURRENCYCHEST[VALUE].COUNT
        );
    }


    function setTransaction (

    )
}