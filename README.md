# Tabby

[![build](https://github.com/metatablecat/Tabby/actions/workflows/build.yml/badge.svg)](https://github.com/metatablecat/Tabby/actions/workflows/build.yml)

The Cat plugin framework

## Installation
* As a Rojo Project
	* **RECOMMENDED** Use this project as a Git submodule in your Rojo project

		```
		git submodule add https://github.com/metatablecat/Tabby.git src/Framework
		```
	* Copy the `src` folder into your `src` folder or the `tabby.rbxm` binary with the name `Framework`
* Within Roblox Studio:
	* Insert the `tabby.rbxm` file into your plugin in Studio

## Basic Usage
To create a simple Tabby project, your plugin will need at least the Tabby framework (named `Framework`) and a `Runtime` folder

This would look like
```
src
  Runtime
  Framework
```

Once you have created that, create a script in Runtime with the name `HelloWorld.lua` and copy this source code

```lua
local Framework = require(script.Parent.Parent.Framework)
local HelloWorldScript = Framework.RuntimeScript "HelloWorld"

HelloWorldScript.Init = function()
	print("Hello World!")
end

return HelloWorldScript
```

Tabby implements many basic features that help with plugin creation, including an interface into the Plugin objects (`PluginToolbar`, `PluginMenu`, `PluginAction`) as well as a basic componentised version of Roblox's Create library

```lua
HelloWorldScript.Init = function()
	Framework.QtInterface:GetToolbar("Hello World!")
		:initialise()
		:AddButton {
			ID = "helloWorldBtn",
			Name = "Hello World!",
			Description = "Says Hello World to the user",
			Callback = function(self)
				self:SetActive(false)
				print("Hello World!")
			end
		} 
end
```

> **Warning:** Only initialise QtInterface singletons once, multiple initialisations of the same interface will cause your code to error
>
> ```lua
> Framework.QtInterface:GetToolbar("Hello World!")
>   :initialise() --OK
>   :initialise() --Error!
> ```

## Features
Tabby implements the following APIs:
* `Action` - a tiny implementation of asynchronous actions with support `await (Action:await)` and handling functions asyncrhonously through `handleAsync (Action:handleAsync)`
* `Create` - a componentised version of Roblox's Create library
* `Event` - a simple Lua event object
* `Form` - a Form object that wraps `DockWidget` with basic features inspired from Windows Forms
* `Input` - an ergonomic wrapper to the legacy plugin mouse input events
* `QtInterface` - an interface for working with the `PluginAction`, `PluginMenu` and `PluginToolbar` types in a singletoned way. (See code above for PluginToolbar example)
* `RuntimeScript` - an API used to prioritise the loading of scripts when the plugin starts (this is one of the main things Tabby relies on)
* Tons of Cat jokes and puns.

Of course, feel free to use whatever you want with Tabby, the sky's the limit.

## Contributing
Feel free to leave issues or pull requests with features you think should be added, I'll consider everything

## Licenses:
Licensed under Apache 2.0

Created by metatablecat
