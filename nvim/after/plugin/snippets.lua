local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local t = ls.text_node

local vscode_loader = require("luasnip.loaders.from_vscode")

vscode_loader.lazy_load()

ls.add_snippets(
  "all",
  {
    ls.parser.parse_snippet("expand", "-- this is what was expanded")
  }
)
ls.add_snippets(
  "lua",
  {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
    s(
      "req",
      {t"local ", i(1, "default"), t" = require(\"", rep(1), t"\")"}
    )
  }
)
