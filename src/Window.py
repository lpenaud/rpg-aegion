#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Original file : https://github.com/lpenaud/rpg-dark-fantasy/blob/master/utils/Window.py

import os
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, Pango, Gdk
from gi.repository.GdkPixbuf import Pixbuf
import utils

class MyWindow(Gtk.Builder):
    """
    A class which add some useful methods

    :param f: Path of glade file
    :type f: str
    """
    def __init__(self, f, winid):
        pathname = utils.resolvePath(f)
        Gtk.Builder.__init__(self)
        self.add_from_file(pathname)
        self.__winid = winid
        self.add_event(
            self.__winid,
            'destroy',
            self.on_delete_window
        )

    def load(self):
        """
        Show main GtkWindow

        :param window: Gtk main window to display it
        :type window: Gtk.Window
        """
        self.get_window().show_all()
        Gtk.main()

    def get_window(self):
        """
        Get window object in the glade file

        :return: Window object
        :rtype: Gtk.Window
        """
        return self.get_object(self.__winid)

    def change_image(self, image_id, pathimg, width=64, height=64):
        """
        Set source of a GtkImage with its id

        :param imageId: Id of a GtkImage
        :type imageId: str
        :param file: Absolute or relative path of the image source
        :type file: str
        :param width: Width in pixel of the image by default 64
        :type width: int
        :param height: Height in pixel of the image by default 64
        :type height: int
        """
        image = Pixbuf.new_from_file_at_size(
            utils.resolvePath(pathimg),
            width=width,
            height=height
        )
        self.get_object(image_id).set_from_pixbuf(image)

    def change_text_label(self, label_id, txt):
        """
        Set text of a GtkLabel with its id

        :param labelId: Id of a GtkLabel
        :type labelId: str
        :param txt: Text to put into the GtkLabel
        :type txt: str
        """
        self.get_object(label_id).set_text(txt)

    def add_event(self, object_id, event, callback, *dataCallback):
        """
        Connect a signal a gtkObject

        :param objectId: Id of the gtkObject
        :type objectId: str
        :param event: Gtk event of the signal compatible with the selected object
        :type event: str
        :param callback: Function invoked when the event is triggered
        :type callback: function
        :return: Handler id to disconnect him
        :rtype: int
        """
        obj = self.get_object(object_id)
        handlerId = obj.connect(event, callback, dataCallback)
        return handlerId

    def on_delete_window(self, *args):
        """
        Procedure triggered when the user left the main window
        """
        Gtk.main_quit(*args)

    def get_children(self, object_id):
        obj = self.get_object(object_id)
        children = []
        if type(obj) is gi.overrides.Gtk.Box:
            children = obj.get_children()
        return children

class Launcher(MyWindow):
    """docstring for Launcher."""
    def __init__(self, glade_file, elements):
        super(Launcher, self).__init__(glade_file, 'window-launcher')
        for name, element in elements.items():
            box_id = 'box-' + name
            image_id = 'image-' + name
            label_id = 'label-' + name
            self.change_image(image_id, element['image'])
            self.change_text_label(label_id, element['label'])
            for child in self.get_children(box_id):
                child.connect('button-press-event', element['callback'])


def set_css_from_file(sheet):
    pathname = utils.resolvePath(sheet)
    provider = Gtk.CssProvider()
    with open(pathname, mode='rb') as f:
        provider.load_from_data(f.read())
    Gtk.StyleContext.add_provider_for_screen(
        Gdk.Screen.get_default(),
        provider,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )

def get_cursor(name):
    return Gdk.Cursor.new_from_name(Gdk.Display.get_default(), name)
