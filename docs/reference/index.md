# API Reference
This page refers to all features currently available in Tabby

??? abstract "Reference Map"
	=== "init.lua exports"
		```lua
		-- Exports
		Tabby.Action = require(Exports.Action)
		Tabby.Create = require(Exports.Create)
		Tabby.Event = require(Exports.Event)
		Tabby.Form = require(Exports.Form)
		Tabby.Input = require(Exports.Input)
		Tabby.Plugin = Plugin
		Tabby.QtInterface = require(script.QtInterface)
		Tabby.RuntimeScript = require(script.Internal.Runtime).newScript

		-- Types
		export type Action<A..., R...> = Types.Action<A..., R...>
		export type Component<RenderParams, Inst> = Types.Component<RenderParams, Inst>
		export type Event<A...> = Types.Event<A...>
		export type Form<O..., C...> = Types.Form<O..., C...>
		export type QtAction = Types.QtAction
		export type QtMenu = Types.QtMenu
		export type QtToolbar = Types.QtToolbar
		export type RuntimeScript = Types.RuntimeScript
		export type TabbyInputObject = Types.TabbyInputObject
		```

	=== "Types.lua type exports"
		```lua
		--@internal/Common
		export type TypedRBXScriptSignal<T...> = {
			Connect: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
			ConnectParallel: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
			Once: (TypedRBXScriptSignal<T...>, func: (T...) -> ()) -> RBXScriptConnection,
			Wait: (TypedRBXScriptSignal<T...>) -> T...,
		}

		--@exports/Action.lua
		export type Action<I..., O...> = {
			_signal: (I...) -> O...,
			Name: string,
			ShowWarnings: boolean,
			await: (Action<I..., O...>, I...) -> (boolean, O...),
			handleAsync: (Action<I..., O...>, func: (boolean, O...) -> (), I...) -> ()
		}

		--@exports/Create.lua
		export type Component<RenderParams, Inst> = {
			ClassName: string,
			_templateInst: Inst?,
			story: ((params: RenderParams) -> Inst)?,
			render: ((params: RenderParams) -> Inst)?,
			GetTemplate: (Component<RenderParams, Inst>, () -> Inst) -> Inst,
			GetCallback: (Component<RenderParams, Inst>) -> (useStoryMode: boolean?) -> (params: RenderParams) -> Inst
		}

		--@exports/Event.lua
		export type Event<A...> = {
			Connect: (Event<A...>, func: (A...) -> ()) -> () -> (),
			ConnectedFunctions: {(A...) -> ()},
			Wait: (Event<A...>) -> A...,
			WaitingThreads: {thread},
			Fire: (Event<A...>, A...) -> ()
		}

		--@exports/Form.lua
		export type Form<O..., C...> = {
			Name: string,
			DockWidget: any,
			IsLoaded: boolean,
			Open: (Form<O..., C...>, O...) -> (),
			Close: (Form<O..., C...>, C...) -> (),
			Loading: (Form<O..., C...>) -> ()?,
			Opening: (Form<O..., C...>, O...) -> ()?,
			Closing: (Form<O..., C...>, C...) -> ()?,
			[string]: any
		}

		--@exports/Input.lua
		export type TabbyInputObject = {
			KeyCode: Enum.KeyCode,
			Position: Vector2,
			UserInputType: Enum.UserInputType,
			UserInputState: Enum.UserInputState
		}

		--@QtInterface
		export type QtInterface<T,M> = {
			ID: string,
			Type: T,
			Mount: M?,
			GetMount: (QtInterface<T,M>) -> M,
			IsA: (QtInterface<T,M>, typeName: string) -> boolean
		}

		type ButtonConfig = {
			ID: string,
			Name: string,
			Description: string,
			Icon: string?,
			ClickableWhenViewportHidden: boolean?,
			Callback: (button: PluginToolbarButton, toolbar: QtToolbar) -> ()?
		}

		export type QtMenu = QtInterface<"PluginMenu", PluginMenu> & {
			initialise: (
				QtMenu,
				title: string?,
				icon: string?
			) -> QtMenu,
			Clear: (QtMenu) -> (),
			ShowAsync: (QtMenu) -> (),
			AddMenu: (QtMenu, menu: QtMenu) -> QtMenu,
			AddAction: (QtMenu, action: QtAction) -> QtMenu,
			AddNewAction: (QtMenu, id: string, title: string?, icon: string?, callback: () -> ()?) -> QtMenu,
			Children: {QtAction|QtMenu},
			ChildActions: {[string]: QtAction},
			ChildMenus: {[string]: QtMenu},
			GetFullTree: (QtMenu) -> {QtAction|QtMenu},
			SetActionIcon: (QtMenu, iconID: string) -> (),
			SetIcon: (QtMenu, iconID: string) -> ()
		}

		export type QtAction = QtInterface<"PluginAction", PluginAction> & {
			initialise: (
				QtAction, 
				name: string?, 
				description: string?,
				icon: string?,
				allowBinding: boolean?,
				callback: () -> ()?
			) -> QtAction,
			IsTemporaryAction: boolean,
			SetIcon: (QtAction, iconID: string) -> never
		}

		export type QtToolbar = QtInterface<"PluginToolbar", PluginToolbar> & {
			initialise: (
				QtToolbar
			) -> QtToolbar,
			AddButton: (QtToolbar, buttonConfig: ButtonConfig) -> QtToolbar,
			SetIcon: (QtToolbar, buttonID: string, iconID: string?) -> (),
			Buttons: {
				[string]: PluginToolbarButton
			}
		}

		--@Internal/RuntimeScript
		export type RuntimeScript = {
			Name: string,
			Priority: number,
			Source: string,
			Init: () -> ()?,
			Activated: () -> ()?,
			Deactivated: () -> ()?,
			Unloading: () -> ()?
		}
		```