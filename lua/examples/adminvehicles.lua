hook.Add ("PlayerSpawnedVehicle", "Admin Only Vehicles", function (pOwner, etSpawned)
    if IsValid (etSpawned) and IsValid (pOwner) and pOwner:IsAdmin () then
        if etSpawned:GetClass () == "prop_vehicle_jeep" then
            etSpawned:AddOutputListener ("PlayerOn", "Admins Only", function (self, pEntered)
                if pEntered:IsAdmin () then
                    timer.Simple (0, function ()
                        pEntered:ExitVehicle ()
                    end)
                end
            end)
        end
    end
end)