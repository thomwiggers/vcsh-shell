#!/usr/bin/python

import os
import gi

gi.require_version('NMClient', '1.0')


def active_connections_changed(*args):
    for sock in os.listdir(os.path.expanduser('~/.ssh/sockets')):
        host, port = sock[len('socket-'):].split(':')
        os.system("ssh -O exit {} -p {}".format(host, port))

if __name__ == "__main__":
    from gi.repository import GLib, NMClient
    c = NMClient.Client.new()
    c.connect('notify::active-connections', active_connections_changed)
    GLib.MainLoop().run()
