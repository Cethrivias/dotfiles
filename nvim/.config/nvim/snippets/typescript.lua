local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
    s(
        'fori',
        fmt(
            [[
for (let {} = 0; {} < {}.length; {}++) {{
   const it = {}[{}]
   {}
}}
]],
            { i(1, 'i'), rep(1), i(2, 'array'), rep(1), rep(2), rep(1), i(0) }
        )
    ),
}
