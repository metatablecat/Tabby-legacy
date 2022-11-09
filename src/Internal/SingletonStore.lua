
local SINGLETON_STORE = {}
local INTERFACE = {}

function INTERFACE:AddClassObject(className: string, objectName: string, object: string)
	-- classable singleton
	local findRoot = SINGLETON_STORE[className]
	if not findRoot then
		findRoot = {}
		SINGLETON_STORE[className] = findRoot
	end

	findRoot[objectName] = object
end

function INTERFACE:AddFloating(name: string, any)
	-- classless singleton
	SINGLETON_STORE[name] = any
end

function INTERFACE:GetClassObject(className: string, name: string)
	local findRoot = SINGLETON_STORE[className] or {}
	return findRoot[name]
end

function INTERFACE:GetFloating(name: string)
	return SINGLETON_STORE[name]
end

return INTERFACE
