# RuntimeScript
RuntimeScript is the main entry point for Tabby when working with the framework.

!!! help "Why is my RuntimeScript not running?"
	There can be a few reasons why your script isn't running, but here are a few common causes with simple fixes, since all warnings are prefixed with `Module did not load because`, the messages have been truncated a bit

	=== "it did not return a RuntimeScript"
		Ensure you're returning a RuntimeScript
			```diff
			+ return HelloWorldScript
			```
	=== "Priority is not a positive integer above 0"
		Use priorites above 0 or dont use `Priority` at all, and only assign numbers to `Priority`
			```diff
			- HelloWorldScript.Priority = -1
			- HelloWorldScript.Priority = "5" --actually a type error
			+ HelloWorldScript.Priority = 5
			```
	=== "it cannot yield!"
		Its common for Plugins to yield when their script starts, however Tabby needs RuntimeScripts to return within the same tick.

		Write your yields instead in the `Init` block
			```diff
			HelloWorldScript.Init = function()
			-   print(meow)
			+   print(yieldingMeow:await())
			end

			- meow = yieldingMeow:await()
			```
	=== "Module did not return exactly one value"
		See `it did not return a RuntimeScript`

```
(string) -> RuntimeScript
```
Returns a new RuntimeScript
!!! warning "RuntimeScripts are singletons"
	You may only have have one `RuntimeScript` assigned to any ID

## `string` Name
The unique name of this `RuntimeScript`

## `number` Priority
The execution priority of this `RuntimeScript` object.

!!! note
	This **must** be a positive integer above 0, it will error otherwise and not load your script

## `string` Source
`[DEPRECATED]`

A leftover property from an older prototype build of Tabby that is no longer maintained, this will always equal `Runtime`.

## Lifecycle Hooks
`RuntimeScript` exposes Lifecycle hooks intended to invoke functions when certain events happen in the outer world of Studio.

All lifecycle hooks have the type of `() -> ()`.
### `function` Activated
Invoked when the plugin is activated through `Input:Activate`

```lua
RuntimeScript.Activated = function()
	-- Do something with the mouse maybe?
end
```

### `function` Deactivated
Invoked when the plugin is deactivated through `Input:Deactivate` or another plugin taking activation control

```lua
RuntimeScript.Deactivated = function()
	-- Stop doing that something with the mouse?
end
```

### `function` Init
Invoked when the plugin has done loading all Runtime scripts

```lua
RuntimeScript.Init = function()
	print("Meow!")
end
```

### `function` Unloading
Invoked when the plugin is unloading

```lua
RuntimeScript.Unloading = function()
	CoreGui.YourVeryCoolPluginGui:Destroy()
end
```

