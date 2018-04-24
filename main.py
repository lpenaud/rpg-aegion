#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from src.Sqlite import Database

db = Database('sql/mydb.db')

db.execute_from_file('sql/RPG.sql')

db.close()
