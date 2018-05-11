#!/usr/bin/python
import sys
import i3ipc

i3 = i3ipc.Connection()
command = sys.argv[1]
direction = sys.argv[2]
window = i3.get_tree().find_focused()
sibblings = window.parent.descendents()
index = sibblings.index(window)
layout = window.parent.layout

def getCommand():
    if direction == 'prev':
        if index == 0:
            if layout in ['splith', 'tabbed']:
                return (command + ' right, ') * (len(sibblings) - 1)
            if layout in ['splitv', 'stacked']:
                return (command + ' up, ') * (len(sibblings) - 1)
        else:
            if layout in ['splith', 'tabbed']:
                return command + ' left'
            if layout in ['splitv', 'stacked']:
                return command + ' up'
    if direction == 'next':
        if len(sibblings) == index + 1:
            if layout in ['splith', 'tabbed']:
                return (command + ' left, ') * index
            if layout in ['splitv', 'stacked']:
                return (command + ' up, ') * index
        else:
            if layout in ['splith', 'tabbed']:
                return command + ' right'
            if layout in ['splitv', 'stacked']:
                return command + ' down'
    if layout not in ['tabbed', 'stacked'] \
        or layout == 'tabbed' and direction in ['up', 'down'] \
        or layout == 'stacked' and direction in ['left', 'right']:
        return command + ' ' + direction
    if command == 'focus':
        return 'focus parent, focus ' + direction
    if command == 'move':
        if direction in ['left', 'up']:
            return ('move ' + direction + ', ') * (index + 1)
        return ('move ' + direction + ', ') * (len(sibblings) - index)

i3.command(getCommand())
