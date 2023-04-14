local t2s = function(...)
    local res = ""
    local tab = -1
    local it
    it = function(t)
        local s = ""
        tab = tab + 1
        for i, v in next,t do 
            local a = typeof(v)
            s = s.."\n"..tostring(tab ~= 0 and string.rep("    ", tab) or "", (((a == "table" or a == "function" or not tonumber(i)) and tab ~= 0) and tostring(i).." = " or (tab == 0 and a == "table") and "start-" or "")..(a=="Instance" and "game."..v:GetFullName() or tostring(v)))
            res = res .. (tab ~= 0 and string.rep("    ", tab) or "") .. " " .. ((((a == "table" or a == "function" or not tonumber(i)) and tab ~= 0) and tostring(i).." = " or (tab == 0 and a == "table") and "start-" or "")..(a=="Instance" and "game."..v:GetFullName() or tostring(v))) .. "\n"
            if a == "table" then  it(v) end
        end
        tab = tab - 1
        return s
    end
    it({...})
    return res
end

print(t2s(getgenv()))
