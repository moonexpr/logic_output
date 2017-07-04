hook.Add ("PlayerSpawnedNPC", "Don't Attack Owner or His Friends", function (pOwner, etSpawned)
    if IsValid (etSpawned) and IsValid (pOwner) then
        if etSpawned:GetClass () == "npc_turret_ceiling" or etSpawned:GetClass () == "npc_turret_floor" then
            etSpawned:SetOwner (pOwner)
            etSpawned:AddOutputListener ("OnDeploy", "Owner Friends", function (self)
                etOwner  = self:GetOwner ()
                etTarget = self:GetEnemy ()

                if etTarget and IsValid (etTarget) and etTarget == etOwner or etTarget:Disposition (etOwner) == D_LI then

                    -- Let's be friends.
                    self:AddEntityRelationship     (etTarget, D_LI, 9999)
                    etTarget:AddEntityRelationship (self,     D_LI, 9999)

                    self:EmitSound ("buttons/blip1.wav")
                    self:SetEnemy (NULL)
                else
                    self:EmitSound ("buttons/button2.wav")
                end
            end)
        end
    end
end)