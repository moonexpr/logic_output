# Logical Outputs
A library used to listen to the outputs of the source entities.
Please don't sell my code without my permission.

## Global Methods

*GetOutputEntity ()* Returns the logical relay entity (Removing this will stop all hooks)
```lua
function GetOutputEntity ()
end
```

## Meta Methods (Entity)

*ENTITY:AddOutputListener* Listen to this entity's output, then call the callback passing output data.
```lua
function ENTITY:AddOutputListener (strOutputEvent, strOutputIdentifier, funcCallback)
end
```

*ENTITY:RemoveOutputListener* Stops listening to this entity's output.
```lua
function ENTITY:RemoveOutputListener (strOutputEvent, strIdentifier)
end
```