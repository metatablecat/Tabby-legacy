# Event
Event works almost identically to `RBXScriptSignal` objects except with a few changes to make them easier to work with.

This object needs to be explicitly casted for typechecking to work on it properly, ie: `local MeowEvent: Event<string> = Event()`

```
Event<A...>(): Event<A...>
```

## `function` Connect
```lua
(Event<A...>, func: (A...) -> ()) -> ()
```
Creates a callback that is fired when the event is signalled.

## `function` Fire
```lua
(Event<A...>, A...) -> ()
```

Signals all connected callbacks then releases waiting threads
!!! warning
	Do not rely on implementation details.

## `function` Wait
```lua
(Event<A...>) -> A...
```

Yields the current thread until the event is fired elsewhere

---

??? danger "Members not safe to write to"
	These members are casted directly onto the object. They are safe to read, but not to write to

	* ConnectedFunctions: `{(A...) -> ()}`
	* WaitingThreads: `{thread}`