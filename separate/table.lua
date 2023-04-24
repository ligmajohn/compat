local filter = function(tbl, func)
    local new = {}
    for i, v in next, tbl do if func(i, v) then new[#new + 1] = v end end
    return new
end

local map = function(tbl, func)
    local new = {}
    for i, v in next, tbl do
        local k, x = func(i, v)
        new[x or #new + 1] = k
    end
    return new
end

local merge = function(...)
    local new = {}
    for i, v in next, {...} do for _, v2 in next, v do new[i] = v2 end end
    return new
end

local indexOf = function(tbl, val)
    for i, v in next, tbl do if v == val then return i end end
end
