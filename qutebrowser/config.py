config.load_autoconfig()
config.source('colors.py')
c.editor.command = ['urxvt', '-e', 'nvim', '{}']
c.url.start_pages = ['https://duckduckgo.com/']
c.hints.chars = 'uiaeo'
c.hints.auto_follow = 'full-match'
c.spellcheck.languages = ['en-US']
c.completion.delay = 50

c.fonts.completion.entry = '8pt monospace'
c.fonts.debug_console = '8pt monospace'
c.fonts.downloads = '8pt monospace'
c.fonts.hints = 'bold 10pt monospace'
c.fonts.keyhint = '8pt monospace'
c.fonts.messages.error = '8pt monospace'
c.fonts.messages.info = '8pt monospace'
c.fonts.messages.warning = '8pt monospace'
c.fonts.prompts = '8pt sans-serif'
c.fonts.statusbar = '8pt monospace'
c.fonts.tabs = '8pt monospace'
