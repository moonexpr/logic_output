ENTITY = FindMetaTable ("Entity")

local CEntityLogicOutputLua = CEntityLogicOutputLua and CEntityLogicOutputLua or NULL

function _G:GetOutputEntity ()
	if not CEntityLogicOutputLua or not IsValid (CEntityLogicOutputLua) then
		CEntityLogicOutputLua = ents.Create ("logic_lua_output")
		CEntityLogicOutputLua:Spawn   ()
		CEntityLogicOutputLua:SetName (CEntityLogicOutputLua:GetClass ())
	end

	return CEntityLogicOutputLua
end

function ENTITY:AddOutputListener (strOutputEvent, strOutputIdentifier, funcCallback)
	CEntityLogicOutputLua = GetOutputEntity ()
	strOutputEvent:gsub (" ", "_")
	CEntityLogicOutputLua:AddHook (self, strOutputEvent, strOutputIdentifier, funcCallback)
end

function ENTITY:RemoveOutputListener (strOutputEvent, strIdentifier)
	CEntityLogicOutputLua = GetOutputEntity ()
	strOutputEvent:gsub (" ", "_")
	CEntityLogicOutputLua:RemoveHook (self, strOutputEvent, strOutputIdentifier)
end