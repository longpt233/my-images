# pip install pymongo==3.11.2

from pymongo import MongoClient 

# client = MongoClient(host="localhost", port=27017)
client = MongoClient('mongodb://admin:admin@localhost:27017/')

db = client.test
# db = client["test"]

print(db)

tutorial1 = {
    "author": "Lucas",
    "contributors": [
         "Aldren",
         "Dan"
     ],
     "url": "https://realpython.com/python-json/"
}

col = db["testcol"]

print(col)

# result = col.insert_one(tutorial1)

test_find = col.find_one({"author": "Lucas"})

print(test_find)