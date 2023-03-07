local firetouched = {}
local networkownertick = tick()
local GetService = game.GetService
local globalenv = (getgenv and getgenv()) or {}

cloneref = globalenv.cloneref or function(...) return ... end
Services = {
    Players = cloneref(game:GetService("Players")),
    Workspace = cloneref(game:GetService("Workspace")),
    CoreGui = cloneref(game:GetService("CoreGui")),
    ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")),
    RunService = cloneref(game:GetService("RunService")),
    HttpService = cloneref(game:GetService("HttpService")),
    UserInputService = cloneref(game:GetService("UserInputService")),
    InsertService = cloneref(game:GetService("InsertService"))
}
setmetatable(Services, {
    __index = function(self, name)
        local suc, result = pcall(GetService, game, name)
        if suc then
            local res = cloneref(result)
            Services[name] = res
            return res
        end
        return nil
    end,
    __mode = "v"
})
game, workspace, wait, spawn, string, math, table = game, workspace, task.wait, task.spawn, string, math, table
LocalPlayer, tfind = Services.Players.LocalPlayer, function(tbl, v)
	for _, v in next, tbl do
		if v == value then
			return v
		end
	end
end
gsub, sub, random, find, lower, gmatch, match = string.gsub, string.sub, math.random, string.find, string.lower, string.gmatch, string.match
insert, remove, cwrap, split, format, upper = table.insert, table.remove, coroutine.wrap, string.split, string.format, string.upper
clamp, round, heartbeat, renderstepped, stepped = math.clamp, math.round, Services.RunService.Heartbeat, Services.RunService.RenderStepped, Services.RunService.Stepped
instnew, cfnew, v3new, sort, pack, unpack = Instance.new, CFrame.new, Vector3.new, table.sort, table.pack, table.unpack
import = function(url)
	local success, result = pcall(function() return game:HttpGet(format("https://raw.githubusercontent.com/ligmajohn/compat/main/libraries/%s.lua", gsub(lower(tostring(url)), " ", "-"))) end)
	if success then return loadstring(game:HttpGet(result))() else return loadstring(game:HttpGet(url))() end
end
Maid = import("maid")
Signal = import("signal")
IsKeyDown = {}
GetKeyCodeName = function(input) return split(tostring(input), ".")[3] end
Services.UserInputService.InputBegan:Connect(function(input, processed)
	if not processed then
		if find(tostring(input.UserInputType), "MouseButton") then
			input = GetKeyCodeName(input.UserInputType)
			IsKeyDown[input] = true
			IsKeyDown[gsub(input, "MouseButton", "MB")] = true
			return
		end
		IsKeyDown[GetKeyCodeName(input.KeyCode)] = true
	end
end)
Services.UserInputService.InputEnded:Connect(function(input, processed)
	if not processed then
		if find(tostring(input.UserInputType), "MouseButton") then
			input = GetKeyCodeName(input.UserInputType)
			IsKeyDown[input] = false
			IsKeyDown[gsub(input, "MouseButton", "MB")] = false
			return
		end
		IsKeyDown[GetKeyCodeName(input.KeyCode)] = false
	end
end)
RandomString = function() return sub(gsub(Services.HttpService:GenerateGUID(false), "-", ""), 1, random(25, 30)) end
GetStringFromKeyCode = function(input)
	return filter(Enum.KeyCode:GetEnumItems(), function(_, v)
		return Services.UserInputService:GetStringForKeyCode(v) == input and v
	end)[1]
end
filter = function(tbl, func)
    local new = {}
    for i, v in next, tbl do
        if func(i, v) then
            new[#new + 1] = v
        end
    end
    return new
end
map = function(tbl, func)
    local new = {}
    for i, v in next, tbl do
        local k, x = func(i, v)
        new[x or #new + 1] = k
    end
    return new
end
merge = function(...)
    local new = {}
    for i, v in next, {...} do
        for _, v2 in next, v do
            new[i] = v2
        end
    end
    return new
end
cons = {connections = {}, loaded = true}
cons.add = function(name, con, func)
	if not func then
		func = con
		con = name
		name = RandomString()
	end
	cons.connections[name] = con:Connect(func)
	return cons.connections[name]
end
cons.remove = function(name)
	if type(name) == "table" then
		for _, connection in next, name do
			if cons.connections[connection] then
				cons.connections[connection]:Disconnect()
				cons.connections[connection] = nil
			end
		end
	else
		if cons.connections[name] then
			cons.connections[name]:Disconnect()
			cons.connections[name] = nil
		end
	end
end
cons.wipe = function()
	for i, v in next, cons.connections do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
			cons.connections[i] = nil
		end
	end
    cons.loaded = false
end
NewInstance = function(class, properties)
    local new = instnew(class)
    for property, value in next, properties do
        new[property] = value
    end
    return new
end
GetCharacter = function(player)
	player = player or LocalPlayer
	return player and player.Character
end
GetHumanoid = function(character)
	character = character or GetCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end
ReplaceHumanoid = function()
	local humanoid = GetHumanoid()
	if humanoid then
		local new = humanoid:Clone()
		new.Parent = humanoid.Parent
		new.Name = humanoid.Name
		humanoid:Destroy()
	end
end
GetBackpack = function(player)
	player = player or LocalPlayer
	return player and player:FindFirstChildOfClass("Backpack")
end
GetRoot = function(character)
	character = character or GetCharacter()
	return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("LowerTorso"))
end
GetMagnitude = function(player)
	local root, root2 = GetRoot(), GetRoot(GetCharacter(player))
	return player and (root and root2 and (root2.Position - root.Position).magnitude) or math.huge
end
sethiddenproperty = globalenv.sethiddenproperty or globalenv.set_hidden_property or globalenv.set_hidden_prop
gethiddenproperty = globalenv.gethiddenproperty or globalenv.get_hidden_property or globalenv.get_hidden_prop
setsimulationradius = globalenv.setsimulationradius or globalenv.set_simulation_radius
request = (globalenv.syn and globalenv.syn.request) or (globalenv.http and globalenv.http.request) or globalenv.http_request or (globalenv.fluxus and globalenv.fluxus.request) or globalenv.request
queue_on_teleport = (globalenv.syn and globalenv.syn.queue_on_teleport) or globalenv.queue_on_teleport or (globalenv.fluxus and globalenv.fluxus.queue_on_teleport)
gethui = globalenv.get_hidden_gui or globalenv.gethui
setclipboard = globalenv.setclipboard or globalenv.toclipboard or globalenv.set_clipboard or (globalenv.Clipboard and globalenv.Clipboard.set)
isfile = globalenv.isfile or (globalenv.readfile and function(...)
    local success, _ = pcall(globalenv.readfile, ...)
    return success
end)
cleanfile = function(str)
    return gsub(str, "[*\\?:<>|]+", "")
end
getconnections = globalenv.getconnections or globalenv.get_signal_cons
setthreadidentity = (globalenv.syn and globalenv.syn.set_thread_identity) or globalenv.setthreadidentity or globalenv.syn_context_set or globalenv.setthreadcontext
getthreadidentity = (globalenv.syn and globalenv.syn.get_thread_identity) or globalenv.getthreadidentity or globalenv.syn_context_get or globalenv.getthreadcontext
getnamecallmethod = globalenv.getnamecallmethod or globalenv.get_namecall_method or function()
    return ""
end
getrawmetatable = globalenv.getrawmetatable or (debug and debug.getmetatable) or function()
    return setmetatable({}, {})
end
checkcaller = globalenv.checkcaller or function()
    return false
end
newcclosure = globalenv.newcclosure or function(f)
    return f
end
setreadonly = globalenv.setreadonly or (globalenv.make_writeable and function(tbl, readonly)
    if readonly then
        globalenv.make_readonly(tbl)
    else
        globalenv.make_writeable(tbl)
    end
end)
isreadyonly = globalenv.isreadonly or globalenv.is_readonly
getscriptclosure = globalenv.getscriptclosure or globalenv.get_script_function
getgc = globalenv.getgc or globalenv.get_gc_objects
getupvalues = (debug and debug.getupvalues) or globalenv.getupvalues or globalenv.getupvals
getconstants = (debug and debug.getconstants) or globalenv.getconstants or globalenv.getconsts
setupvalue = (debug and debug.setupvalue) or globalenv.setupvalue or globalenv.setupval
setconstant = (debug and debug.setconstant) or globalenv.setconstant or globalenv.setconst
getinfo = (debug and (debug.getinfo or debug.info)) or globalenv.getinfo
hookfunction = globalenv.hookfunction or function(func, newfunc, applycclosure)
    if globalenv.replaceclosure then
        globalenv.replaceclosure(func, newfunc)
        return func
    end
    func = applycclosure and globalenv.newcclosure or newfunc
    return func
end
hookmetamethod = globalenv.hookmetamethod or (hookfunction and function(object, method, hook)
    return hookfunction(getrawmetatable(object)[method], hook)
end)
firetouchinterest = globalenv.firetouchinterest or function(part1, part2, toggle)
    if part1 and part2 then
        if toggle == 0 then
            firetouched[1] = part1.CFrame
            part1.CFrame = part2.CFrame
        else
            part1.CFrame = firetouched[1]
            firetouched[1] = nil
        end
    end
end
isnetworkowner = globalenv.isnetworkowner or function(part)
    if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
        sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
        networkownertick = tick() + 8
    end
    return networkownertick <= tick()
end
getcustomasset = globalenv.getsynasset or globalenv.getcustomasset or function(location)
    return "rbxasset://" .. location
end
isexecutorclosure = globalenv.isexecutorclosure or globalenv.is_synapse_function
islclosure = globalenv.islclosure or globalenv.is_lclosure
local GarbageCollectorChecks = {
    ["function"] = function(Obj, Data) 
        local Name, Constants, Upvalues, IgnoreSyn = (Data.Name), (Data.Constants or {}), (Data.Upvalues or {}), ((Data.IgnoreSyn == nil) or (Data.IgnoreExec == nil)) and true or false
        local ObjName, ObjConstants, ObjUpvalues, ObjIsSyn = (getinfo(Obj).name), (islclosure(Obj) and getconstants(Obj) or {}), (getupvalues(Obj) or {}), (isexecutorclosure(Obj))
        if IgnoreSyn and ObjIsSyn then return false end
        if Name and ObjName and Name ~= ObjName then return false end
        for _, v in next, Constants do
            if not tfind(ObjConstants, v) then
                return false
            end
        end
        for _, v in next, Upvalues do
            if not tfind(ObjUpvalues, v) then
                return false
            end
        end
        return true
    end,
    ["table"] = function(Obj, Data) 
        local Keys, Values, KeyValuePairs, Metatable = (Data.Keys or {}), (Data.Values or {}), (Data.KeyValuePairs or {}), (Data.Metatable or {})
        local ObjMetatable = getrawmetatable(Obj)
        if ObjMetatable then
            for i, v in next, ObjMetatable do
                if (Metatable[i] ~= v) then
                    return false
                end
            end
        end
        for _, v in next, Keys do
            if not Obj[v] then
                return false
            end
        end
        for _, v in next, Values do
            if not tfind(Obj, v) then
                return false
            end
        end
        for i, v in next, KeyValuePairs do
            local Other = Obj[i]
            if Other ~= v then
                return false
            end
        end
        return true
    end,
}
filtergc = filtergc or (getgc and function(Type, Data, One)
    local Results = {}
    for _, v in next, getgc(true) do
        if type(v) == Type then
            if GarbageCollectorChecks[Type](v, Data) then
                if One then
                    return v
                end
                insert(Results, v)
            end
        end
    end
    return Results
end)
ImportESP = function()
    local ESP = import("https://raw.githubusercontent.com/ligmajohn/backups/main/esp/main.lua")
    ESP:Toggle(false)
    ESP.Players = false
    ESP.Tracers = false
    ESP.Boxes = false
    ESP.Names = false
    ESP.Color = ESP.Presets.Green
    return ESP
end
