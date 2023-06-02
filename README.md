(Not working on this anymore, feel free to maintain it yourself)

# Tabby

The Cat plugin framework

## Installation
Download the latest [Release](https://github.com/metatablecat/Tabby/releases), and place it into your project as expected

If you want to use an unstable build of Tabby, build the contents provided under `src` using Rojo

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

Read more at https://metatablecat.github.io/Tabby

## Features
Tabby implements the following APIs:
* `Action` - a tiny implementation of asynchronous actions with support `await (Action:await)` and handling functions asyncrhonously through `handleAsync (Action:handleAsync)`
* `Event` - a simple Lua event object
* `Form` - a Form object that wraps `DockWidget` with basic features inspired from Windows Forms
* `Input` - an ergonomic wrapper to the legacy plugin mouse input events
* `QtInterface` - an interface for working with the `PluginAction`, `PluginMenu` and `PluginToolbar` types in a singletoned way. (See code above for PluginToolbar example)
* `RuntimeScript` - an API used to prioritise the loading of scripts when the plugin starts (this is one of the main things Tabby relies on)
* Tons of Cat jokes and puns.

Of course, feel free to use whatever you want with Tabby, the sky's the limit.

## Contributing
Feel free to leave issues or pull requests with features you think should be added, I'll consider everything

Development of later builds can be found on the `overalls` branch. Please create pull requests against this branch and not `master`

## Licenses:
Licensed under Apache 2.0

Created by metatablecat
