-- Misc functions
local Common = {}
local SINGLETON_STORE = require(script.Parent.SingletonStore)

Common.Plugin = script:FindFirstAncestorOfClass("Plugin")
function Common.IsLikelyInterfaceObject(interfaceObject): (boolean, string?)
	if typeof(interfaceObject) ~= "table" then
		return false
	end
	
	local getType = interfaceObject.Type
	if getType then
		return true, getType
	end
	
	return false
end

function Common.InterfaceInit(self, hookCallback)
	if SINGLETON_STORE:GetClassObject(self.Type, self.ID) then
		error(self.ID .. " can only exist once!")
	end

	local obj = hookCallback()
	self.Mount = obj
	SINGLETON_STORE:AddClassObject(self.Type, self.ID, self)
	obj.Name = Common.FormatQtName(self.Type, self.ID)
	return obj
end

function Common.FormatQtName(qtype, name)
	return string.format("%s [%s]", qtype, name)
end

function Common.FindEnumItemFromValue(enum: Enum, number)
	for _, v in enum:GetEnumItems() do
		if v.Value == number then
			return v
		end
	end
end

function Common.GetKeyCodeEnumFromChar(k)
	local byte = string.byte(k)
	local keyCode = Common.FindEnumItemFromValue(Enum.KeyCode, byte)
	return keyCode
end

return Common