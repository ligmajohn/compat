-- The filter() method creates a new array with all elements that pass the test implemented by the provided function.
local filter = function(tbl, func)
	local new = {}
	for i, v in next, tbl do if func(i, v) then new[#new + 1] = v end end
	return new
end

-- The map() method creates a new array populated with the results of calling a provided function on every element in the calling array.
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
	for _, v in next, {...} do
		local i = last:FindFirstChild(v)
		if i then
			last = i
		else
			last = false
			break
		end
	end
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

--[[
	"Error:2: attempt to perform arithmetic (add) on nil and number"
	-->
	"attempt to perform arithmetic (add) on nil and number"
]]
local errorFormat = function(output)
	return output:match("%d+: (.+)")
end
