from solcx import compile_standard, install_solc, compile_files, compile_source, link_code
from web3.auto import w3
from marshmallow import Schema, fields, ValidationError
import json

account_key = w3.eth.accounts[1]


# def getSnackReviews(snack_id):
#     snack_reviews = []
#     with open("data.json", 'r') as f:
#         datastore = json.load(f)
#     abi = datastore["abi"]
#     contract_address = datastore["contract_address"]

#     # Create the contract instance with the newly-deployed address
#     contract = w3.eth.contract(
#         address=contract_address, abi=abi,
#     )

#     for i in range(contract.functions.get_array_length(snack_id).call()):
#         temp = contract.functions.getReview(snack_id, i).call()
#         snack_review = {
#             "USER_EMAIL": temp[0],
#             "USER_NAME": temp[1],
#             "SNACK_ID": temp[2],
#             "SNACK_REVIEW": temp[3],
#             "SCHEDULE_DATE": temp[4],
#             "SNACK_RATING": temp[5]
#         }
#         snack_reviews.append(snack_review)

#     return (snack_reviews)

# def getSnackUserReviews(snack_id, user_email, schedule_date):
#     with open("data.json", 'r') as f:
#         datastore = json.load(f)
#     abi = datastore["abi"]
#     contract_address = datastore["contract_address"]

#     # Create the contract instance with the newly-deployed address
#     contract = w3.eth.contract(
#         address=contract_address, abi=abi,
#     )

#     return (contract.functions.getUserReview(snack_id, user_email, schedule_date).call())



def deploy_contract(contract_interface):
    # Instantiate and deploy contract
    account = account_key
    # print(account)
    contract = w3.eth.contract(
    abi=contract_interface['abi'],
    bytecode=contract_interface['bin']
    )
# Get transaction hash from deployed contract
    ''''
    tx_hash = contract.deploy(
    transaction={'from': w3.eth.accounts[1]}
    )
# Get tx receipt to get contract address
    tx_receipt = w3.eth.getTransactionReceipt(tx_hash)
    '''
    
    construct_txn = contract.constructor().build_transaction(
        {
            "gasPrice": 0, 
            'from': account,
            'nonce': w3.eth.get_transaction_count(account),
        }
    )

    # 6. Sign tx with PK
    # tx_create = w3.eth.account.sign_transaction(construct_txn, account.private_key)

    # 7. Send tx and wait for receipt
    # tx_hash = w3.eth.send_raw_transaction(tx_create.rawTransaction)
    tx_hash = w3.eth.send_transaction(construct_txn)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)


    return tx_receipt['contractAddress']

# compile all contract files
#contracts = compile_files(['review.sol', 'stringUtils.sol'])
def compile_contract():
    _solc_version = "0.4.24"
    install_solc(_solc_version)
    review = open("transaction.sol","r").read()
    stringUtils = open("stringUtils.sol","r").read()
    '''
    contracts = compile_standard(
        {
            "language": "Solidity",
            import_remappings=['=./pathDirectory', '-'])
            "sources": {"./review.sol": {"content": review}},
            "settings": {
                "outputSelection": {
                    "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
                }
            },
        },
        solc_version=_solc_version,
    )
    '''
    contracts = compile_source(
        review,
        output_values=["abi", "bin", "metadata"],
        solc_version=_solc_version
    )
    #print(contracts)


    # separate main file and link file
    # main_contract = contracts.pop("review.sol:reviewRecords")
    # library_link = contracts.pop("stringUtils.sol:StringUtils")
    main_contract = contracts.pop("<stdin>:Transaction")

    contracts = compile_source(
        stringUtils,
        output_values=["abi", "bin", "metadata"],
        solc_version=_solc_version
    )
    library_link = contracts.pop("<stdin>:StringUtils")



    library_address = {
        "stringUtils.sol:StringUtils": deploy_contract(library_link)
    }

    main_contract['bin'] = link_code(
        main_contract['bin'], library_address
    )

    # add abi(application binary interface) and transaction reciept in json file
    with open('data.json', 'w') as outfile:
        data = {
        "abi": main_contract['abi'],
        "contract_address": deploy_contract(main_contract)
        }
        json.dump(data, outfile, indent=4, sort_keys=True)


    with open("data.json", 'r') as f:
        datastore = json.load(f)
        abi = datastore["abi"]
        contract_address = datastore["contract_address"]


    

"""
def transaction(account_key, USER_EMAIL, USER_NAME, SNACK_ID, SNACK_REVIEW, SCHEDULE_DATE, SNACK_RATING):
    body = {"USER_EMAIL":USER_EMAIL, 'USER_NAME':USER_NAME, 'SNACK_ID':SNACK_ID, 'SNACK_REVIEW':SNACK_REVIEW, 'SCHEDULE_DATE':SCHEDULE_DATE, 'SNACK_RATING':SNACK_RATING}
    w3.eth.defaultAccount = account_key
    with open("data.json", 'r') as f:
        datastore = json.load(f)
    abi = datastore["abi"]
    contract_address = datastore["contract_address"]

    # Create the contract instance with the newly-deployed address
    user = w3.eth.contract(
        address=contract_address, abi=abi,
    )
    #body = request.get_json()
    #result, error = ReviewSchema().load(body)
    result = ReviewSchema().load(body)
    '''
    if error:        
        return jsonify(error), 422
    '''
    tx_hash = user.functions.setReview(
        result['USER_EMAIL'], result['USER_NAME'], result['SNACK_ID'], result['SNACK_REVIEW'], result['SCHEDULE_DATE'], result['SNACK_RATING']
    )
    tx_hash = tx_hash.transact({'from': w3.eth.defaultAccount})
    # Wait for transaction to be mined...
    w3.eth.wait_for_transaction_receipt(tx_hash)
    #user_data = user.functions.getReview().call()
    #print(user_data)
"""


