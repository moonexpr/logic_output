ENT.Base 	= "base_point"
ENT.Type 	= "point"
ENT.Author	= "Potatofactory"
ENT.Hooks 	= {}

function ENT:AddHook (etOutputListening, strOutputEvent, strOutputIdentifier, funcCallback)
	if not etOutputListening or not type (etOutputListening) == "Entity" or not IsValid (etOutputListening) then
		error (("Argument #1 epected a entity, we got a %s %s. [excution halted]"):format (type (etOutputListening), IsValid (etOutputListening) and "valid" or "non-valid"))
	end

	if not strOutputEvent or type (strOutputEvent) ~= "string" then
		error (("Argument #2 epected a string, we got a %s. [excution halted]"):format (type (strOutputEvent)))
	end

	if not strOutputIdentifier or type (strOutputIdentifier) ~= "string" then
		error (("Argument #3 epected a string, we got a %s. [excution halted]"):format (type (strOutputIdentifier)))
	end

	if not funcCallback or type (funcCallback) ~= "function" then
		error (("Argument #4 epected a function, we got a %s. [excution halted]"):format (type (funcCallback)))
	end

	if not self.Hooks then
		self.Hooks = {}
	end

	if not self.Hooks [etOutputListening] then
		self.Hooks [etOutputListening] = {}
	end

	if not self.Hooks [etOutputListening][strOutputEvent] then
		self.Hooks [etOutputListening][strOutputEvent] = {}
	end

	self.Hooks [etOutputListening][strOutputEvent][strOutputIdentifier] = funcCallback

	etOutputListening:Fire ("addoutput", ("%s %s,%s"):format (strOutputEvent, self:GetName (), strOutputEvent))
end

function ENT:RemoveHook (etOutputListening, strOutputEvent, strOutputIdentifier)
	if not etOutputListening or type (etOutputListening) ~= "Entity" or not IsValid (etOutputListening) then
		error (("Argument #1 epected an entity, we got a %s. [excution halted]"):format (type (etOutputListening)))
	end

	if not strOutputEvent or type (strOutputEvent) ~= "string" then
		error (("Argument #2 epected an string, we got a %s. [excution halted]"):format (type (strOutputEvent)))
	end

	if not strOutputIdentifier or type (strOutputIdentifier) ~= "string" then
		error (("Argument #3 epected an string, we got a %s. [excution halted]"):format (type (strOutputIdentifier)))
	end

	if not self.Hooks [etOutputListening] or not self.Hooks [etOutputListening][strOutputEvent] or not self.Hooks [etOutputListening][strOutputEvent][strOutputIdentifier] then
		return
	end

	if self.Hooks [etOutputListening][strOutputEvent][strOutputIdentifier] then
		self.Hooks [etOutputListening][strOutputEvent][strOutputIdentifier] = nil
	end

	-- Small optimizations
	if table.Count (self.Hooks [etOutputListening][strOutputEvent]) == 0 then
		self.Hooks [etOutputListening][strOutputEvent] = nil
	end

	if table.Count (self.Hooks [etOutputListening]) == 0 then
		self.Hooks [etOutputListening] = nil
	end
end

function ENT:IsValidHook (etOutputListening, strOutputEvent)
	return tobool (self.Hooks [etOutputListening] and self.Hooks [etOutputListening][strOutputEvent])
end


function ENT:AcceptInput (strOutputEvent, etOutputDispatcher, etOutputListening, ...)
	if not self:IsValidHook (etOutputListening, strOutputEvent) then
		return false
	end

	for strIdentifier, funcCallback in pairs (self.Hooks [etOutputListening][strOutputEvent]) do
		bSuccess, strError = pcall (funcCallback, etOutputListening, etOutputDispatcher, ...)

		if not bSuccess then
			error (("Output Dispatch Failed on %s: [%s/%s] %s\n"):Format (etOutputDispatcher, strOutputEvent, strIdentifier, strError))
		end
	end

	return false
end

function ENT:GetHooks ()
	return self.Hooks
end