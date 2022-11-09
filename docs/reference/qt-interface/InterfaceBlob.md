
# InterfaceBlob
InterfaceBlob is the superclass for the QtInterface objects. It cannot be created externally.

!!! warning "InterfaceBlobs are singletons"
	You can only initialise InterfaceBlobs once, every future initialisation will fail

## `function` GetMount
```
(InterfaceBlob) -> Instance?
```

Returns the currently loaded `Instance` in the Interface (this will be typecasted when used because QtInterface itself is generic)

## `string` ID
The ID used to initialise this object from one of the `QtInterface:Get` methods.

## `function` IsA
```
(InterfaceBlob, Type: string) -> boolean
```

Matches the type of the blob against the parameter value.

## `string<Literal>` Type
The literal type of this Interface, when used in an inheritor, has a literal string type

---

??? danger "Members not safe to write to"
	These members are casted directly onto the object. They are safe to read, but not to write to

	* Mount: `any` (Use GetMount instead.)