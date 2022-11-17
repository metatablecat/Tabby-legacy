local Common = require(script.Parent.Parent.Internal.Common)
local Event = require(script.Parent.Event)
local Types = require(script.Parent.Parent.Types)
local Plugin = Common.Plugin

local DO_NOT_UPDATE_THIS_PROP = newproxy(false)
local Settings = {}
local SettingChangedEvents = {}
local SettingChanged: Types.Event<string, any> = Event()

local function invokeSettingChangedEvent(name, newValue)
	local e = SettingChangedEvents[name]
	if e then
		e:Fire(newValue)
	end

	SettingChanged:Fire(name, newValue)
end

function Settings:SetSetting(name: string, setting: any)
	Plugin:SetSetting(name, setting)
	invokeSettingChangedEvent(name, setting)
end

function Settings:GetSetting(name: string)
	return Plugin:GetSetting(name)
end

function Settings:GetSettingChangedSignal(name)
	local e = SettingChangedEvents[name]
	if not e then
		e = Event() :: Types.Event<any>
		SettingChangedEvents[name] = e
	end

	return e.Signal
end

function Settings:UpdateSetting(name, update: <T>(T) -> T)
	local oldVal = Settings:GetSetting(name)
	local newVal = select(1, update(oldVal)) or DO_NOT_UPDATE_THIS_PROP
	if newVal ~= DO_NOT_UPDATE_THIS_PROP then
		Settings:SetSetting(name, newVal)
	end
end

Settings.SettingChanged = SettingChanged.Signal
return Settings