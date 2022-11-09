# Action
Actions provide a way to create asynchronous execution that can be either awaited upon or handled asynchronously

```
Action<I..., O...>(actionName: string, callback: (I...) -> R...) -> Action<I..., O...>
```

Creates a new `Action` object

## `function` await
```lua
(Action<I..., O...>, I...) -> (boolean, O...)
```
Yields the running thread calls the action with `I...`, returns if it worked, and either the return params as `O...`, or an error as `string`.

## `function` handleAsync
```lua
(Action<I..., O...>, func: (boolean, O...) -> (), I...) -> ()
```

Runs the action asynchronously and returns the result to `func`. This function works similary to `await` except it's response is sent to a callback asynchronously.

## `string` Name
Refers to the name of the `Action` defined in the constructor

## `boolean` ShowWarnings
Controls if errors from `await` are warned into the console, default = `false`

---

??? danger "Members not safe to write to"
	These members are casted directly onto the object. They are safe to read, but not to write to

	* _signal: `(I...) -> O...`