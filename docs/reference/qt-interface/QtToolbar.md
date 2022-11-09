# QtToolbar
`inherits InterfaceBlob with generic types "PluginToolbar" and PluginToolbar`

## `function` AddButton
```
(QtToolbar, buttonConfig: ButtonConfig) -> QtToolbar
```

Adds a button to the toolbar. This can be chained as such: `initialise():AddButton():AddButton()...`

??? abstract "Button Config Type"

	```
	type ButtonConfig = {
		ID: string,
		Name: string,
		Description: string,
		Icon: string?,
		ClickableWhenViewportHidden: boolean?,
		Callback: (button: PluginToolbarButton, toolbar: QtToolbar) -> ()?
	}
	```

## `table` Buttons
```
{[string]: PluginToolbarButton}
```

A table of buttons indexed by their IDs

## `function` initialise
```
(QtToolbar) -> QtToolbar
```

Initialises the toolbar.

## `function` SetIcon
```
(QtToolbar, buttonID: string, iconID: string?) -> ()
```

Changes a button icon, matching it against it's ID.