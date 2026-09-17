local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local csharp = require 'custom.csharp'

---@param trig string
---@param keyword string
local function type_snippet(trig, keyword)
    return s({ trig = trig, desc = keyword .. ' from filename' }, fmt('public ' .. keyword .. ' {}\n{{\n    {}\n}}', {
        f(csharp.type_name),
        i(0),
    }))
end

return {
    s(
        'testa',
        fmt(
            [[
[Test]
public async Task {}()
{{
    // Arrange
    {}
    // Act
    // Assert
}}
]],
            { i(1), i(2) }
        )
    ),
    s('aaa', t { '// Arrange', '// Act', '// Assert' }),
    s('newguid', t 'Guid.NewGuid()'),
    s(
        { trig = 'ns', desc = 'File-scoped namespace from path' },
        fmt('namespace {};', {
            f(function()
                return csharp.namespace()
            end),
        })
    ),
    type_snippet('class', 'class'),
    type_snippet('interface', 'interface'),
    type_snippet('record', 'record'),
    type_snippet('struct', 'struct'),
}
