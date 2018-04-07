#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from src.Sqlite import Database

db = Database('sql/mydb.db')

db.execute_from_file('sql/sample.sql')

data_to_insert = [
    {
        'name': 'ypenaud',
        'age': 22
    },
    {
        'name': 'mpenaud',
        'age': 25
    }
]

print('INSERT')
db.insertmany('users', data_to_insert)
data = db.selectall('SELECT * FROM users')
for value in data:
    print(value)

data_to_update = data_to_insert[0].copy()
data_to_update['name'] = 'freddy'
data_to_update['age'] = 20

print('UPDATE')
db.update('users', data_to_update, 'id=1 OR id=3')
data = db.selectall('SELECT * FROM users')
for value in data:
    print(value)

db.close()
