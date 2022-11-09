# QtAction
`inherits InterfaceBlob with generic types "PluginAction" and PluginAction`

Acts as a wrapper for the `PluginAction` object.

## `function` initialise
```
(QtAction, name: string?, description: string?, icon: string?, allowBinding: boolean?, callback: () -> ()?) -> QtAction
```

Initialises the QtAction by creating a `PluginAction`

## `boolean` IsTemporaryAction
If this action was created through a `QtMenu`.

!!! warning
	Do not store temporary QtActions in the few places where they're exposed, only interface with it from iterating over `QtMenu.ChildActions`/`QtMenu.Children`

## `function` SetIcon
!!! failure "Unimplemented"
	This is unimplemented, do not use it. It exists hoping Roblox gives a way to change `PluginAction` icons.