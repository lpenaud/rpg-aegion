#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

sys.path.insert(0, 'src')

import Window
import utils
import Sqlite

def lottery_cb(*args):
    print('lottery triggered')

def characters_cb(*args):
    print('characters triggered')

def bestiary_cb(*args):
    print('bestiary triggered')

def armory_cb(*args):
    print('characters triggered')

laucher_elements = {
    'lottery': {
        'label': 'Loterie',
        'image': 'images/d20-128x128.png',
        'callback': lottery_cb
    },
    'characters': {
        'label': 'Fiches de personnages',
        'image': 'images/knight-128.png',
        'callback': characters_cb
    },
    'bestiary': {
        'label': 'Bestiaire',
        'image': 'images/skeleton-128x128.png',
        'callback': bestiary_cb
    },
    'armory': {
        'label': 'Armurerie',
        'image': 'images/sword-128x128.png',
        'callback': armory_cb
    }
}

db = Sqlite.Database('sql/RPG.db', auto_commit = True)
db.execute_from_file('sql/RPG.sql')
Window.set_css_from_file('css/launcher.css')
app = Window.Launcher('glade/launcher.glade', laucher_elements)
app.load()
db.close()
