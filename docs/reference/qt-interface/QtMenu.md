# QtMenu
`inherits InterfaceBlob with generic types "PluginMenu" and PluginMenu`

This acts as a wrapper for the `PluginMenu` object. This is a very developed and complex wrapper.

## `function` AddAction
```
(QtMenu, action: QtAction) -> QtMenu
```
Adds a pre-existing `QtAction` to the menu.

## `function` AddNewAction
```
(QtMenu, id: string, title: string?, icon: string?, callback: () -> ()?) -> QtMenu
```
Creates a temporary action and assigns it to the menu.

!!! warning
	Do not store temporary QtActions in the few places where they're exposed, only interface with it from iterating over `QtMenu.ChildActions`/`QtMenu.Children`

## `function` AddMenu
```
(QtMenu, menu: QtMenu) -> QtMenu
```
Adds a sub-menu to the menu

!!! danger
	This should be obvious, but no, you cannot add a menu as a sub-menu of itself. **Please stop trying this, im serious**

## `table` ChildActions
```
{[string]: QtAction}
```
A table indexed by Action ID of `QtActions` in the menu

## `table` ChildMenus
```
{[string]: QtMenu}
```
A table indexed by Menu ID of sub `QtMenus` in the menu

## `table` Children
```
{QtAction|QtMenu}
```
An ordered list of `QtActions` and `QtMenus` in the list, this is in the order of how it's displayed

## `function` Clear
```
(QtMenu) -> ()
```
Clears the menu of all actions and sub-menus, and deletes temporary actions.

## `function` GetFullTree
```
(QtMenu) -> {QtAction|QtMenu}
```

Returns all members of the menu and submenus. The order is undefined.

## `function` initialise
```
(QtMenu, title: string?, icon: string?) -> QtMenu
```

Initialises the menu.

## `function` SetActionIcon
!!! failure "Unimplemented"
	This is unimplemented, do not use it. It exists hoping Roblox gives a way to change `PluginAction` icons.

## `function` SetIcon
```
(QtAction, iconID: string) -> ()
```
Changes the Menu icon

## `function` ShowAsync
```
(QtAction) -> ()
```
Shows the menu