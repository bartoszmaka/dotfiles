return {
  'HiPhish/rainbow-delimiters.nvim',
  keys = {
    { '<leader>ur', function() require('rainbow-delimiters').toggle() end },
  },
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'

    require('rainbow-delimiters.setup').setup {
      whitelist = {
        'xml',
        'xml.erb',
        'html',
        'html.erb',
        'javascript',
        'javascript.jsx',
        'javascriptreact',
        'typecript',
        'typecript.jsx',
        'typecriptreact',
      },
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
      },
      query = {
        [''] = 'rainbow-parens',
        javascript = 'rainbow-tag-brackets-react',
        xml = 'rainbow-tag-brackets-delimiters',
        html = 'rainbow-delimiters-tag-brackets',
      },
      priority = {
        [''] = 110,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end
}

-- JavaScript
-- (jsx_element
--   open_tag: (jsx_opening_element
--               "<" @delimiter
--               name: (identifier)
--               ">" @delimiter)
--   close_tag: (jsx_closing_element
--                "</" @delimiter
--                name: (identifier)
--                ">" @delimiter @sentinel)) @container

-- (jsx_element
--   open_tag: (jsx_opening_element
--               "<" @delimiter
--               name: (member_expression)
--               ">" @delimiter)
--   close_tag: (jsx_closing_element
--               "</" @delimiter
--                name: (member_expression)
--               ">" @delimiter @sentinel)) @container

-- (jsx_self_closing_element
--   "<" @delimiter
--   name: (identifier)
--   "/>" @delimiter @sentinel) @container

-- (jsx_self_closing_element
--   "<" @delimiter
--   name: (member_expression)
--   "/>" @delimiter @sentinel) @container

-- XML
-- (element
--   (STag
--     "<" @delimiter
--     (Name)
--     ">" @delimiter)
--   (ETag
--     "</" @delimiter
--     (Name)
--     ">" @delimiter @sentinel))@container

-- (element
--   (EmptyElemTag
--     "<" @delimiter
--     (Name)
--     "/>" @delimiter @sentinel)) @container

-- HTML
-- ;;; A pair of delimiter tags with any content in-between.
-- ;;; Last tag should be a sentinel.

-- ;;; If instead you want rainbow-delimiters to only highlight
-- ;;; the tag names without any of "<", "</", ">" or "/>", then
-- ;;; you can make your own query file, e.g.,
-- ;;;   'rainbow-tag-names'
-- ;;; and use the following with
-- ;;;   x @delimiter
-- ;;; deleted for x equal to any of "<", "</", ">" or "/>".

-- (element
--   (start_tag
--     "<" @delimiter
--     (tag_name)
--     ">" @delimiter)
--   (end_tag
--     "</" @delimiter
--     (tag_name)
--     ">" @delimiter @sentinel)) @container

-- (element
--   (self_closing_tag
--     "<" @delimiter
--     (tag_name)
--     "/>" @delimiter @sentinel)) @container

-- (element
--   (start_tag
--     "<" @delimiter
--     (tag_name) @_tag_name
--     ">" @delimiter @sentinel)
--   (#any-of? @_tag_name
--    "area"
--    "base"
--    "br"
--    "col"
--    "embed"
--    "hr"
--    "img"
--    "input"
--    "link"
--    "meta"
--    "param"
--    "source"
--    "track"
--    "wbr")
-- ) @container

-- (style_element
--   (start_tag
--     "<" @delimiter
--     (tag_name)
--     ">" @delimiter)
--   (element (self_closing_tag) @delimiter)*
--   (end_tag
--     "</" @delimiter
--     (tag_name
--     ">" @delimiter @sentinel)) @container

-- (script_element
--   (start_tag
--     "<" @delimiter
--     (tag_name)
--     ">" @delimiter)
--   (end_tag
--     "</" @delimiter
--     (tag_name)
--     ">" @delimiter @sentinel)) @container
