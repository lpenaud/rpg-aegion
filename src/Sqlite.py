#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sqlite3

class Database(sqlite3.Connection):
    """
    Create a sqlite3 DB (based on sqlite3.Connection)

    :param db: Pathname of the database
    :type db: str
    :param auto_commit: If the database have to commit automatically by default set to True
    :type auto_commit: bool
    """
    def __init__(self, db, auto_commit = True):
        super(Database, self).__init__(db)
        self.row_factory = Database.dict_factory
        self.__auto_commit = auto_commit

    @staticmethod
    def dict_factory(cursor, row):
        """
        Return a dictionary instead of a tuple when you SELECT data
        See https://docs.python.org/3/library/sqlite3.html#sqlite3.Connection.row_factory
        """
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d

    @property
    def auto_commit(self):
        """
        Property to set if the database have to commit automatically.
        auto_commit have to be boolean, otherwise raise a TypeError.
        """
        return self.__auto_commit

    @auto_commit.setter
    def auto_commit(self, auto_commit):
        if type(auto_commit) is bool:
            self.__auto_commit = auto_commit
        else:
            raise TypeError('auto_commit have to be a boolean')

    def execute(self, req, data = {}):
        """
        Execute a SQL instruction

        :param req: SQL request to execute
        :type req: str
        :param data: Data of the request (for INSERT and UPDATE) by default a empty dictionary
        :type data: dict
        :retrun: Result of the request
        :rtype: sqlite3.Cursor
        """
        res = self.cursor().execute(req, data)
        if not('SELECT' in req) and self.auto_commit:
            self.commit()
        return res

    def executemany(self, req, data = ()):
        """
        Execute same instruction x times according to "data" variable length

        :param req: SQL request to execute
        :type req: str
        :param data: Data for the request by default a tuple
        :type data: tuple, list
        :retrun: Result of the request
        :rtype: sqlite3.Cursor
        """
        res = self.cursor().executemany(req, data)
        if not('SELECT' in req) and self.auto_commit:
            self.commit()
        return res

    def execute_from_file(self, filename):
        """
        Execute a SQL script

        :param filename: Filename of a SQL script
        :type filename: str
        """
        with open(filename, mode='r', encoding='utf-8') as f:
            self.cursor().executescript(f.read())
        if self.auto_commit:
            self.commit()

    def selectone(self, req):
        """
        Fetch one tuple of SELECT request

        :param req: SQL SELECT request
        :type req: str
        :return: A tuple
        :rtype: dict
        """
        if 'SELECT' in req:
            return self.execute(req).fetchone()
        raise Error('You selected no data')

    def selectall(self, req):
        """
        Fetch all tuple of SELECT request

        :param req: SQL SELECT request
        :type req: str
        :return: Tuples of dictionary
        :rtype: tuple
        """
        return self.execute(req).fetchall()

    def __generate_insert(self, table, fields):
        fields_values = []
        for field in fields:
            fields_values.append(':' + field)
        return 'INSERT INTO {table_name}({names}) VALUES ({values})'.format(
            table_name = table,
            names = ','.join(fields),
            values = ','.join(fields_values)
        )

    def insertone(self, table, data):
        """
        Insert data once.

        :param table: Name of table where data will be inserted
        :type table: str
        :param data: Dictionary of data to INSERT
        :type data: dict
        """
        req = self.__generate_insert(table, data.keys())
        self.execute(req, data)

    def insertmany(self, table, data):
        """
        Insert many data

        :param table: Name of table where data will be inserted
        :type table: str
        :param data: Tuple of dictionary of data to INSERT
        :type data: tuple, list
        """
        req = self.__generate_insert(table, data[0].keys())
        self.executemany(req, data)

    def __generate_update(self, table, fields, where):
        fields_values = []
        req = 'UPDATE {table_name} SET {values}'
        if len(where) > 0:
            req += ' WHERE ' + where
        for field in fields:
            fields_values.append(field + '=:' + field)
        return req.format(
            table_name = table,
            values = ','.join(fields_values)
        )

    def update(self, table, data, where = ''):
        """
        Update data of a table

        :param table: Name of table where data will be updated
        :type table: str
        :param data: Tuple of dictionary of data to UPDATE
        """
        req = self.__generate_update(table, data.keys(), where)
        self.execute(req, data)
