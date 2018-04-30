#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Original file : https://github.com/lpenaud/rpg-dark-fantasy/blob/master/utils/utils.py

import os
import sys
import json

def load_json(strf):
    """
    load a JSON file in a dict

    :param strf: name of the json file
    :type strf: str
    :return: data in JSON file
    :rtype: dict
    """
    data = {}

    if not(isinstance(strf, str)):
        raise TypeError("arg must be a str")

    with open(strf, mode='r', encoding="utf-8-sig") as f:
        data = json.loads(f.read())

    return data

def is_frozen():
    """
    Test if the application is frozen (pyinstaller)

    :return: True/False depend if the application is frozen
    :rtype: bool
    """
    return getattr(sys, 'frozen', False)

def resolve_path(f):
    """
    Get absolute path of a file (All the files imports have to use this function)

    :param f: Paths relative to the file whose departure is the root of the application
    :type f: str
    :return: Absolute path of the file
    :rtype: str
    """
    if is_frozen():
        path = os.path.dirname(os.path.realpath(__file__)) + '/'
    else:
        path = os.path.dirname(os.path.realpath(__file__)) + '/../'

    return os.path.abspath(path + f)
