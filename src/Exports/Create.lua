-- Create framework
local Types = require(script.Parent.Parent.Types)
type Component<RenderParams, Inst> = Types.Component<RenderParams, Inst>

local Create = {}
Create.Component = {}

local function extract(t, k)
	local v = t[k]
	t[k] = nil
	return v
end

local function getCallback<R,I>(self: Component<R,I>, useStory: boolean?): (R) -> I
	local findCallback = if useStory
		then self.story
		else self.render

	if not findCallback then
		-- TODO: nicer error
		error("Cannot find valid callback for component")
	end

	return findCallback
end

function Create.Component<R, I>(comName: string): Component<R, I>
	local COM = {}
	COM.ClassName = comName
	COM._templateInst = nil
	COM.story = nil
	COM.render = nil

	function COM:GetTemplate(templateCallback: () -> I): I
		if not COM._templateInst then
			COM._templateInst = templateCallback()
		end

		return COM._templateInst:Clone()
	end

	function COM:GetCallback(): (useStoryMode: boolean?) -> (R) -> I
		return function(useStoryMode)
			return getCallback(self, useStoryMode)
		end
	end

	return COM
end

function Create.new(className: string)
	return function(props: {[string]: any, Children: {[string]: Instance}?})
		local children = extract(props, "Children") or {}
		local parent = extract(props, "Parent")
		if parent then
			props.Parent = nil
		end

		local inst = Instance.new(className)
		for childName, child in children do
			child.Name = childName
			child.Parent = inst
		end

		for propName, propVal in props do
			inst[propName] = propVal
		end

		if parent then
			inst.Parent = parent
		end

		return inst
	end
end

return Create