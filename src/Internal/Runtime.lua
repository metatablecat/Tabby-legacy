-- Implements RuntimeScript engine
local SCRIPT_MAP = {}
local Types = require(script.Parent.Parent.Types)
type RuntimeScript = Types.RuntimeScript
local RuntimeAPI = {}

local function foreachScript(key, ...)
	for _, v in SCRIPT_MAP do
		local funcBinding = v[key]
		if funcBinding then
			task.spawn(funcBinding, v, ...)
		end
	end
end

RuntimeAPI.CHECK_HEADER = newproxy(false) -- used to ensure the state of a RuntimeScript

function RuntimeAPI:MapRuntimeScripts(rtScripts: {RuntimeScript})
	-- maps the scripts in priority
	-- this groups scripts into lists of priorities then flattents it into the map
	local priorityMap = {}
	local highestPriority = 1
	for _, rtScript in rtScripts do
		local priority = rtScript.Priority or 1
		if typeof(priority) ~= "number" or priority < 1 then
			warn("Module '" .. rtScript.Name .. " did not load because Priority is not a positive integer above 0")
			continue
		else
			priority = math.floor(priority)
		end

		local list = priorityMap[priority]
		if not list then
			list = {}
			priorityMap[priority] = list
		end

		if priority > highestPriority then
			highestPriority = priority
		end
		
		table.insert(list, rtScript)
	end

	-- map into script list
	for i = 1, highestPriority do
		local list = priorityMap[i]

		if list then
			for _, v in list do
				table.insert(SCRIPT_MAP, v)
			end
		end
	end
end

function RuntimeAPI:InvokeLifecycleAsync(key, ...)
	-- invokes the Lifecycle calls asynchronously, respecting priority
	foreachScript(key, ...)
end

function RuntimeAPI.newScript(scriptName: string): RuntimeScript
	-- returns a new Runtime Script
	local rtScript = {}
	rtScript.Name = scriptName
	rtScript.Priority = 1
	rtScript.Source = "Unknown"
	rtScript.CHECK_HEADER = RuntimeAPI.CHECK_HEADER

	return rtScript
end

return RuntimeAPI