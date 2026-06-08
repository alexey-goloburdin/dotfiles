local wezterm = require 'wezterm'

local act = wezterm.action

local keys = {}

for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function basename(path)
  if not path or path == '' then
    return 'Debian'
  end

  path = tostring(path)

  -- если это file:// URI
  path = path:gsub('^file://[^/]*', '')

  -- убрать trailing slash
  path = path:gsub('/+$', '')

  local name = path:match('([^/]+)$')
  return name or 'Debian'
end

wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir

  return {
    { Text = ' ' .. (tab.tab_index + 1) .. ': ' .. basename(cwd) .. ' ' },
  }
end)

return {
  -- WSL
  default_domain = 'WSL:Debian',

  -- Theme — see https://wezterm.org/colorschemes/a/index.html
  --color_scheme = "Sonokai (Gogh)",
  --color_scheme = "Tokyo Night",
  --color_scheme = "3024 Night (Gogh)",
  --color_scheme = "Afterglow",
  --color_scheme = "Alien Blood (Gogh)",
  --color_scheme = "Apprentice (Gogh)",
  --color_scheme = "Arthur",
  --color_scheme = "Ashes (base16)",
  --color_scheme = "Atelier Savanna (base16)",
  --color_scheme = "ayu",
  --color_scheme = "Tomorrow Night (Gogh)",
  --color_scheme = "Trim Yer Beard (terminal.sexy)",
  --color_scheme = "VWbug (terminal.sexy)",
  --color_scheme = "Wombat",
  color_scheme = "X::Erosion (terminal.sexy)",
  --color_scheme = "darkmoss (base64)",
  --color_scheme = "duskfox",
  --color_scheme = "flexoki-dark",
  --color_scheme = "jmbi (terminal.sexy)",
  --color_scheme = "kanagawabones",
  --color_scheme = "nordfox",
  --color_scheme = "rose-pine",
  --color_scheme = "s3r0 modified (terminal.sexy)",
  --color_scheme = "zenwritten_dark",
  --color_scheme = "Decaf (base16)",
  --color_scheme = "Default (dark) (terminal.sexy)",
  --color_scheme = "Gogh (Gogh)",
  --color_scheme = "Gruvbox Dark (Gogh)",
  --color_scheme = "Gruvbox Material (Gogh)",
  --color_scheme = "Gruvbox dark, pale (base16)",
  --color_scheme = "Hardcore",
  --color_scheme = "Hybrid",
  --color_scheme = "Japanesque (Gogh)",
  --color_scheme = "Ocean Dark (Gogh)",
  --color_scheme = "OneDark (Gogh)",
  --color_scheme = "Operator Mono Dark",
  --color_scheme = "Red Planet",
  --color_scheme = "Rippedcasts",
  --color_scheme = "Srcery (Gogh)",

  -- Font
  font = wezterm.font('Hack Nerd Font'),
  font_size = 11,

  -- Transparency
  window_background_opacity = 1.0,
  text_background_opacity = 1.0,

  -- Windows 11 blur
  win32_system_backdrop = 'Acrylic',

  -- Window
  initial_cols = 140,
  initial_rows = 40,

  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15,
  },

  -- Hide title bar
  window_decorations = "RESIZE",

  -- Cursor
  default_cursor_style = 'SteadyBlock',

  -- Scrollback
  scrollback_lines = 10000,

  -- Better rendering
  front_end = 'WebGpu',

  -- Disable annoying bell
  audible_bell = 'Disabled',

  -- Keys
  keys = keys,
}
