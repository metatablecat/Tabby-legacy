local Tabby = {}
local Types = require(script.Types)
local Common = require(script.Internal.Common)

local Plugin = Common.Plugin
if not Plugin then
	error("Plugin handle missing, make sure you're running this under a Plugin.")
end
local Exports = script.Exports

-- Exports (please keep these ordered)
Tabby.Action = require(Exports.Action)
Tabby.Event = require(Exports.Event)
Tabby.Form = require(Exports.Form)
Tabby.Input = require(Exports.Input)
Tabby.Plugin = Plugin
Tabby.QtInterface = require(script.QtInterface)
Tabby.RuntimeScript = require(script.Internal.Runtime).newScript
Tabby.Settings = require(script.Exports.Settings)

-- Types
export type Action<A..., R...> = Types.Action<A..., R...>
export type Event<A...> = Types.Event<A...>
export type Form<O..., C...> = Types.Form<O..., C...>
export type QtAction = Types.QtAction
export type QtMenu = Types.QtMenu
export type QtToolbar = Types.QtToolbar
export type RuntimeScript = Types.RuntimeScript
export type TabbyInputObject = Types.TabbyInputObject

return Tabby