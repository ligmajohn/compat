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

local resolvePath = function(parent, ...)
    local last = parent
    for _, v in next, {...} do last = last:FindFirstChild(v) or last:WaitForChild(v) end
    return last
end

local rng = Random.new()
local shuffle = function(from)
	for i = #from, 2, -1 do
		local j = rng:NextInteger(1, i)
		from[i], from[j] = from[j], from[i]
	end
	return from
end

local errorFormat = function(output)
    return output:match("%d+: (.+)")
end
