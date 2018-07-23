#!/usr/bin/env python
import i3ipc

def getCommand(window, command, direction):
    sibblings = window.parent.descendents()
    index = sibblings.index(window)
    layout = window.parent.layout
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

directions = ['left', 'right', 'up', 'down', 'next', 'prev']
commands = ['focus', 'move']

def on_event(i3, e):
    [command, direction] = (e.binding.command + (' ' * 5)).split(' ')[3:5]
    if not command in commands or not direction in directions: return
    window = i3.get_tree().find_focused()
    i3.command(getCommand(window, command, direction))

i3 = i3ipc.Connection()
i3.on('binding', on_event)
i3.main()
