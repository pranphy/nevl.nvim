local M = {}
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
M.tprint = function(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            M.tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))      
        else
            print(formatting .. v)
        end
    end
end

M.merge = function(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then M.merge(a[k],v) else a[k]=v end end
    end
    return a
end

return M
