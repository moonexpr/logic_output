hook.Add ("PlayerSpawnedNPC", "Attacking Scanners", function (pOwner, etSpawned)
    if IsValid (etSpawned) and IsValid (pOwner) then
        if etSpawned:GetClass () == "npc_cscanner" then
            etSpawned:AddOutputListener ("OnPhotographPlayer", "Attack",
                function (self, pPickup)

                    CTakeDamageInfo = DamageInfo ()
                    CTakeDamageInfo:SetAttacker   (self)
                    CTakeDamageInfo:SetDamage     (10)
                    CTakeDamageInfo:SetDamageType (DMG_DISSOLVE)

                    pPickup:TakeDamageInfo (CTakeDamageInfo)
                end
            )
        end
    end
end)