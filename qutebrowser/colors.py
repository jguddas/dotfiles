import subprocess

def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources('*')

black       = xresources.get('*.color0', 'black')
darkred     = xresources.get('*.color1', 'darkred')
darkgreen   = xresources.get('*.color2', 'darkgreen')
darkorange  = xresources.get('*.color3', 'darkorange')
darkblue    = xresources.get('*.color4', 'darkblue')
darkmagenta = xresources.get('*.color5', 'darkmagenta')
darkcyan    = xresources.get('*.color6', 'darkcyan')
grey        = xresources.get('*.color7', 'grey')
darkgrey    = xresources.get('*.color8', 'darkgrey')
red         = xresources.get('*.color9', 'red')
green       = xresources.get('*.color10', 'green')
orange      = xresources.get('*.color11', 'orange')
blue        = xresources.get('*.color12', 'blue')
magenta     = xresources.get('*.color13', 'magenta')
cyan        = xresources.get('*.color14', 'cyan')
white       = xresources.get('*.color15', 'white')

## Background color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.bg = darkgrey

## Bottom border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.bottom = black

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.top = black

## Foreground color of completion widget category headers.
## Type: QtColor
c.colors.completion.category.fg = white

## Background color of the completion widget for even rows.
## Type: QssColor
c.colors.completion.even.bg = black

## Text color of the completion widget.
## Type: QtColor
c.colors.completion.fg = white

## Background color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.bg = darkgreen

## Bottom border color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.border.bottom = green

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.item.selected.border.top = green

## Foreground color of the selected completion item.
## Type: QtColor
c.colors.completion.item.selected.fg = white

## Foreground color of the matched text in the completion.
## Type: QssColor
c.colors.completion.match.fg = red

## Background color of the completion widget for odd rows.
## Type: QssColor
c.colors.completion.odd.bg = black

## Color of the scrollbar in completion view
## Type: QssColor
c.colors.completion.scrollbar.bg = darkgrey

## Color of the scrollbar handle in completion view.
## Type: QssColor
c.colors.completion.scrollbar.fg = grey

## Background color for the download bar.
## Type: QssColor
c.colors.downloads.bar.bg = black

## Background color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.bg = red

## Foreground color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.fg = white

## Color gradient start for download backgrounds.
## Type: QtColor
c.colors.downloads.start.bg = blue

## Color gradient start for download text.
## Type: QtColor
c.colors.downloads.start.fg = white

## Color gradient stop for download backgrounds.
## Type: QtColor
c.colors.downloads.stop.bg = green

## Color gradient end for download text.
## Type: QtColor
c.colors.downloads.stop.fg = white

## Background color for hints.
## Type: QssColor
c.colors.hints.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 ' + green + ', stop:1 ' + darkgreen + ')'

## CSS border value for hints.
## Type: String
c.hints.border = '1px solid ' + green

## Font color for hints.
## Type: QssColor
c.colors.hints.fg = white

## Font color for the matched part of hints.
## Type: QssColor
c.colors.hints.match.fg = darkgrey

## Text color for the keyhint widget.
## Type: QssColor
c.colors.keyhint.fg = white

## Highlight color for keys to complete the current keychain.
## Type: QssColor
c.colors.keyhint.suffix.fg = orange

## Background color of an error message.
## Type: QssColor
c.colors.messages.error.bg = darkred

## Border color of an error message.
## Type: QssColor
c.colors.messages.error.border = red

## Foreground color of an error message.
## Type: QssColor
c.colors.messages.error.fg = white

## Background color of an info message.
## Type: QssColor
c.colors.messages.info.bg = black

## Border color of an info message.
## Type: QssColor
c.colors.messages.info.border = darkgrey

## Foreground color an info message.
## Type: QssColor
c.colors.messages.info.fg = white

## Background color of a warning message.
## Type: QssColor
c.colors.messages.warning.bg = darkorange

## Border color of a warning message.
## Type: QssColor
c.colors.messages.warning.border = orange

## Foreground color a warning message.
## Type: QssColor
c.colors.messages.warning.fg = white

## Background color for prompts.
## Type: QssColor
c.colors.prompts.bg = grey

## Foreground color for prompts.
## Type: QssColor
c.colors.prompts.fg = white

## Background color for the selected item in filename prompts.
## Type: QssColor
c.colors.prompts.selected.bg = grey

## Background color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.bg = magenta

## Foreground color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.fg = white

## Background color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.bg = magenta

## Foreground color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.fg = white

## Background color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.bg = black

## Foreground color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.fg = white

## Background color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.bg = darkgrey

## Foreground color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.fg = white

## Background color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.bg = darkgreen

## Foreground color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.fg = white

## Background color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.bg = black

## Foreground color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.fg = white

## Background color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.bg = darkblue

## Foreground color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.fg = white

## Background color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.bg = darkgrey

## Foreground color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.fg = white

## Background color of the progress bar.
## Type: QssColor
c.colors.statusbar.progress.bg = white

## Foreground color of the URL in the statusbar on error.
## Type: QssColor
c.colors.statusbar.url.error.fg = orange

## Default foreground color of the URL in the statusbar.
## Type: QssColor
c.colors.statusbar.url.fg = white

## Foreground color of the URL in the statusbar for hovered links.
## Type: QssColor
c.colors.statusbar.url.hover.fg = cyan

## Foreground color of the URL in the statusbar on successful load (http).
## Type: QssColor
c.colors.statusbar.url.success.http.fg = white

## Foreground color of the URL in the statusbar on successful load (https).
## Type: QssColor
c.colors.statusbar.url.success.https.fg = green

## Foreground color of the URL in the statusbar when there's a warning.
## Type: QssColor
c.colors.statusbar.url.warn.fg = orange

## Background color of the tab bar.
## Type: QtColor
c.colors.tabs.bar.bg = darkgrey

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = darkgrey

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = white

## Color for the tab indicator on errors.
## Type: QtColor
c.colors.tabs.indicator.error = red

## Color gradient start for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.start = blue

## Color gradient end for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.stop = green

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = darkgrey

## Foreground color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.fg = white

## Background color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.bg = green

## Foreground color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.fg = white

## Background color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.bg = green

## Foreground color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.fg = white

## Background color for webpages if unset (or empty to use the theme's color)
## Type: QtColor
c.colors.webpage.bg = white


