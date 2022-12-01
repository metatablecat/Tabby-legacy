-- TODO: Implement more stuff (I shipped this on a prototype build which didnt have everything ready)
-- Initialise fast flags (for now, have no reason to consume it, just need to init it here)
local RunService = game:GetService("RunService")

require(script.Parent.Internal.Flags)

local function GetDataModelSessionType()
	return if RunService:IsEdit() then
		"Edit"
	else if RunService:IsClient() then
		"PlayClient"
	else
		"PlayServer"
end

local Runtime = require(script.Parent.Internal.Runtime)
local DataModelSessionType = GetDataModelSessionType()
Runtime.DataModelSessionType = DataModelSessionType

local RtSource = script.Parent.Parent:FindFirstChild("Runtime")
local ScriptMap = {}

local function requireNoYield(module: ModuleScript)
	-- a version of require that cant yield
	local worked, out
	local thread = task.spawn(function()
		worked, out = pcall(require, module)
	end)
	
	if coroutine.status(thread) ~= "dead" then
		warn("Module '".. module.Name .. "' did not load because it cannot yield")
		return
	end

	if not worked then
		warn("Module '" .. module.Name .. "' did not load because: " .. out)
		return
	end

	-- assert contents to ensure it's a Runtime script or Runtime script-ish
	if typeof(out) ~= "table" or out.CHECK_HEADER ~= Runtime.CHECK_HEADER then
		warn("Module '" .. module.Name .. "' did not load because it did not return a RuntimeScript")
		return
	end

	return out
end

local function LoadRuntime(rtSourceFolder)
	for _, mod in rtSourceFolder:GetChildren() do
		if mod:IsA("ModuleScript") then
			local module = requireNoYield(mod)
			if module then
				table.insert(ScriptMap, module)
			end
		end
	end
end

LoadRuntime(RtSource)
Runtime:MapRuntimeScripts(ScriptMap)
Runtime:InvokeLifecycleAsync("Init")

plugin.Unloading:Connect(function()
	Runtime:InvokeLifecycleAsync("Unloading")
end)