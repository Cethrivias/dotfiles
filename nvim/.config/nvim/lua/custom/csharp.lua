local M = {}

---@param start_dir string
---@return string|nil
local function find_csproj(start_dir)
    local found = vim.fs.find(function(name)
        return name:sub(-7) == '.csproj'
    end, {
        path = start_dir,
        upward = true,
        type = 'file',
        limit = 1,
    })
    return found[1]
end

---@param csproj string
---@return string
local function root_namespace(csproj)
    local ok, lines = pcall(vim.fn.readfile, csproj)
    if ok then
        local text = table.concat(lines, '\n')
        local root = text:match '<RootNamespace[^>]*>([^<]+)</RootNamespace>'
        if root then
            root = vim.trim(root)
            if root ~= '' and not root:find '%$' then
                return root
            end
        end
    end
    return vim.fn.fnamemodify(csproj, ':t:r')
end

---@param part string
---@return string
local function to_identifier(part)
    part = part:gsub('%-', '_')
    part = part:gsub('[^%w_]', '')
    if part:match '^%d' then
        part = '_' .. part
    end
    return part
end

---@param rel string
---@return string
local function folders_to_namespace(rel)
    local parts = {}
    for part in rel:gmatch '[^/\\]+' do
        if part ~= '.' and part ~= 'bin' and part ~= 'obj' then
            local ident = to_identifier(part)
            if ident ~= '' then
                parts[#parts + 1] = ident
            end
        end
    end
    return table.concat(parts, '.')
end

---@param path? string
---@return string
function M.namespace(path)
    path = path and path ~= '' and path or vim.api.nvim_buf_get_name(0)
    if path == '' then
        return 'Namespace'
    end

    path = vim.fs.normalize(path)
    local file_dir = vim.fs.dirname(path)
    local csproj = find_csproj(file_dir)

    local root
    local base_dir
    if csproj then
        root = root_namespace(csproj)
        base_dir = vim.fs.dirname(csproj)
    else
        base_dir = vim.uv.cwd()
    end

    local rel = base_dir and vim.fs.relpath(base_dir, file_dir) or nil
    local nested = rel and folders_to_namespace(rel) or ''

    if root and nested ~= '' then
        return root .. '.' .. nested
    end
    if root then
        return root
    end
    if nested ~= '' then
        return nested
    end
    return 'Namespace'
end

---@param path? string
---@return string
function M.type_name(path)
    path = path and path ~= '' and path or vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(path, ':t:r')
    if name == '' then
        return 'Type'
    end
    return name
end

return M
